# - explore: mapped_events
view: mapped_events {
  derived_table: {
    #sql_trigger_value: select count(*) from ${page_aliases_mapping.SQL_TABLE_NAME} ;;
    sql: select *
        ,datediff(minute, lag(timestamp) over(partition by looker_visitor_id order by timestamp), timestamp) as idle_time_minutes
      from (
        select cast(t.timestamp AS string) ||  t.anonymous_id ||  '-t' as event_id
          ,t.anonymous_id
          ,t.id as detail_track_id
          ,coalesce(a2v.looker_visitor_id,a2v.alias) as looker_visitor_id
          ,t.timestamp
          , NULL as context_campaign_source
          , NULL as context_campaign_name
          , NULL as referrer
          ,'tracks' as event_source
        from SAN_WEBSITE_PROD.tracks as t
        inner join ${page_aliases_mapping.SQL_TABLE_NAME} as a2v
        on a2v.alias = coalesce(t.user_id, t.anonymous_id)

        union all

        select cast(t.timestamp AS string) || t.anonymous_id || '-p' as event_id
          ,t.anonymous_id
          , NULL as detail_track_id
          ,coalesce(a2v.looker_visitor_id,a2v.alias) as looker_visitor_id
          ,t.timestamp
          ,t.context_campaign_source as context_campaign_source
          , t.context_campaign_name as context_campaign_name
          ,t.referrer as referrer
          ,'pages' as event_source
        from SAN_WEBSITE_PROD.pages as t
        inner join ${page_aliases_mapping.SQL_TABLE_NAME} as a2v
          on a2v.alias = coalesce(t.user_id, t.anonymous_id)
      ) as e
       ;;
  }

  dimension: event_id {
    sql: ${TABLE}.event_id ;;
  }

  dimension: detail_track_id {
    sql: ${TABLE}.detail_track_id ;;
  }

  dimension: looker_visitor_id {
    sql: ${TABLE}.looker_visitor_id ;;
  }

  dimension: anonymous_id {
    sql: ${TABLE}.anonymous_id ;;
  }

  dimension: context_campaign_source {
    sql: ${TABLE}.context_campaign_source ;;
  }

  dimension_group: timestamp {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.timestamp ;;
  }

  # dimension: event {
  #   sql: ${TABLE}.event;;
  # }


  dimension: referrer {
    sql: ${TABLE}.referrer ;;
  }

  dimension: event_source {
    sql: ${TABLE}.event_source ;;
  }

  dimension: idle_time_minutes {
    type: number
    sql: ${TABLE}.idle_time_minutes ;;
  }

  set: detail {
    fields: [
      event_id,
      looker_visitor_id,
      referrer,
      event_source,
      idle_time_minutes
    ]
  }
}
