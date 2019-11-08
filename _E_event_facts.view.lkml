view: event_facts {
  derived_table: {
    # Rebuilds after sessions rebuilds
    #sql_trigger_value: select count(*) from ${sessions_pg_trk.SQL_TABLE_NAME} ;;
    sql: select t.timestamp
        , t.anonymous_id
        , t.event_id
        , t.detail_track_id
        , first_value(t.context_campaign_source) over (partition by s.session_id order by t.timestamp rows between unbounded preceding and unbounded following) as first_campaign_source
        , first_value(t.context_campaign_name) over (partition by s.session_id order by t.timestamp rows between unbounded preceding and unbounded following) as first_campaign_name
        , first_value(t.context_campaign_name) over (partition by s.session_id order by t.timestamp rows between unbounded preceding and unbounded following) as first_campaign_name
        , last_value(t.event) over (partition by s.session_id order by t.timestamp rows between unbounded preceding and unbounded following) as last_event_session
        , t.event_source
        , t.event
        , s.session_id
        , t.looker_visitor_id
        , t.context_user_agent
        , t.referrer as referrer
        , row_number() over(partition by s.session_id order by t.timestamp) as track_sequence_number
        , row_number() over(partition by s.session_id, t.event_source order by t.timestamp) as source_sequence_number
        , first_value(t.referrer) over (partition by s.session_id order by t.timestamp rows between unbounded preceding and unbounded following) as first_referrer
      from ${mapped_events.SQL_TABLE_NAME} as t
      left join ${sessions_pg_trk.SQL_TABLE_NAME} as s
      on t.looker_visitor_id = s.looker_visitor_id
        and t.timestamp >= s.session_start_at
        and (t.timestamp < s.next_session_start_at or s.next_session_start_at is null)
       ;;
  }

  dimension: event_id {
    primary_key: yes
    #     hidden: true
    sql: ${TABLE}.event_id ;;
  }

  dimension: session_id {
    sql: ${TABLE}.session_id ;;
  }

  dimension: first_referrer {
    sql: ${TABLE}.first_referrer ;;
  }

  dimension: first_referrer_domain {
    sql: split_part(${first_referrer},'/',3) ;;
  }

  dimension: first_referrer_domain_mapped {
    sql: CASE WHEN ${first_referrer_domain} like '%facebook%' THEN 'facebook' WHEN ${first_referrer_domain} like '%google%' THEN 'google' ELSE ${first_referrer_domain} END ;;
  }

  dimension: looker_visitor_id {
    type: string
    sql: ${TABLE}.looker_visitor_id ;;
  }

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}.anonymous_id ;;
  }

  dimension: sequence_number {
    type: number
    sql: ${TABLE}.track_sequence_number ;;
  }

  dimension: source_sequence_number {
    type: number
    sql: ${TABLE}.source_sequence_number ;;
  }

  dimension: event {
    type: number
    sql: ${TABLE}.event ;;
  }

  measure: count_visitors {
    type: count_distinct
    sql: ${looker_visitor_id} ;;
  }

  dimension: useragent {
    sql: ${TABLE}.context_user_agent ;;
  }

  dimension: device {
    sql: CASE
          WHEN ((${useragent} LIKE '%iphone%' OR ${useragent} LIKE '%iPhone%' OR ${useragent} LIKE '%Windows mobile%' OR ${useragent} LIKE '%Windows phone%' OR ${useragent} LIKE '%Windows Phone%' OR ${useragent} LIKE '%Nexus 5%' OR ${useragent} LIKE '%GTI-9300%' OR ${useragent} LIKE '%Nokia%' OR ${useragent} LIKE '%SGH-M919V%' OR ${useragent} LIKE '%SCH-%' OR ${useragent} LIKE '%Mobile%' OR ${useragent} LIKE '%Opera mini%') AND (${useragent} NOT LIKE '%iPad%')) THEN 'mobile'
          WHEN ((${useragent} LIKE '%Windows%' OR ${useragent} LIKE '%WOW64%' OR ${useragent} LIKE '%Intel Mac OS%' OR ${useragent} LIKE '%Windows NT 6.1; Trident/7.0%' OR ${useragent} LIKE '%Media Center PC%') AND (${useragent} NOT LIKE '%iPad%')) THEN 'desktop'
          WHEN (${useragent} LIKE '%Tablet PC%' OR ${useragent} LIKE '%Touch%' OR ${useragent} LIKE '%MyPhone%' OR ${useragent} LIKE '%iPad%' OR ${useragent} LIKE '%ipad%' OR ${useragent} LIKE '%Tablet%') THEN 'tablet'
          ELSE 'unknown'
          END ;;
  }
}
