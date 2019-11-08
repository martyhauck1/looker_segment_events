view: session_pg_trk_facts {
  derived_table: {
    # Rebuilds after track_facts rebuilds
    # sql_trigger_value: select COUNT(*) from ${event_facts.SQL_TABLE_NAME} ;;
    sql: select s.session_id
        , first_referrer
        , first_campaign_source
        , first_campaign_medium
        , first_campaign_name
        , last_event_session
        , max(t2s.timestamp) as end_at
        , count(case when t2s.event_source = 'tracks' then 1 else null end) as tracks_count
        , sum(case when t2s.event = 'product_viewed' then 1 else null end) as cnt_viewed_product
        , sum(case when t2s.event = 'product_added' then 1 else null end) as cnt_product_added
        , sum(case when t2s.event = 'order_completed' then 1 else null end) as cnt_order_completed
        , sum(case when t2s.event = 'checkout_started' then 1 else null end) as cnt_checkout_started
        , sum(case when t2s.event = 'cart_viewed' then 1 else null end) as cnt_cart_viewed
        , sum(case when t2s.event = 'Home-p' then 1 else null end) as cnt_homepage_view
        , sum(case when t2s.event = 'checkout_step_completed' then 1 else null end) as cnt_checkout_step_completed
        , sum(case when t2s.event in ('signed_up','subscribed') then 1 else null end) as cnt_subscribed


      from ${sessions_pg_trk.SQL_TABLE_NAME} as s
        inner join ${event_facts.SQL_TABLE_NAME} as t2s
          on s.session_id = t2s.session_id
          --using(session_id)
      group by 1,2,3,4,5,6
       ;;
  }

  # ----- Dimensions -----

  dimension: session_id {
    primary_key: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension: first_referrer {
    sql: ${TABLE}.first_referrer ;;
  }

  dimension: last_event_session {
    sql: ${TABLE}.last_event_session ;;
  }

  dimension: first_campaign_source {
    sql: ${TABLE}.first_campaign_source ;;
  }

  dimension: first_campaign_medium {
    sql: ${TABLE}.first_campaign_medium ;;
  }

  dimension: first_campaign_name {
    sql: ${TABLE}.first_campaign_name ;;
  }

  dimension: first_referrer_domain {
    sql: split_part(${first_referrer},'/',3) ;;
  }

  dimension: first_referrer_domain_mapped {
    sql: CASE WHEN ${first_referrer_domain} like '%facebook%' THEN 'facebook' WHEN ${first_referrer_domain} like '%google%' THEN 'google' ELSE ${first_referrer_domain} END ;;
  }

  dimension_group: end {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.end_at ;;
  }

  dimension: tracks_count {
    type: number
    sql: ${TABLE}.tracks_count ;;
  }

  dimension: referrer {
    type: number
    sql: ${TABLE}.referrer ;;
  }

  dimension: tracks_count_tier {
    type: tier
    sql: ${tracks_count} ;;
    tiers: [
      1,
      5,
      10,
      20,
      30,
      60
    ]
  }

  dimension: is_bounced_session {
    sql: CASE WHEN ${tracks_count} = 1 THEN 'Bounced Session'
      ELSE 'Not Bounced Session' END
       ;;
  }

  dimension: session_duration_minutes {
    type: number
    sql: datediff(minutes, ${sessions_pg_trk.start_raw}, ${end_raw}) ;;
  }

  dimension: session_duration_minutes_tiered {
    type: tier
    sql: ${session_duration_minutes} ;;
    tiers: [
      1,
      5,
      10,
      20,
      30,
      60
    ]
  }

  dimension: product_viewed {
    type: yesno
    sql: ${TABLE}.cnt_viewed_product > 0 ;;
  }

  dimension: product_added {
    type: yesno
    sql: ${TABLE}.cnt_product_added > 0 ;;
  }

  dimension: order_completed {
    type: yesno
    sql: ${TABLE}.cnt_order_completed > 0 ;;
  }


  dimension: checkout_started {
    type: yesno
    sql: ${TABLE}.cnt_checkout_started > 0 ;;
  }

  dimension: homepage_view {
    type: yesno
    sql: ${TABLE}.cnt_homepage_view > 0 ;;
  }

  dimension: checkout_step_completed {
    type: yesno
    sql: ${TABLE}.cnt_checkout_step_completed > 0 ;;
  }

  dimension: subscribed {
    type: yesno
    sql: ${TABLE}.cnt_subscribed > 0 ;;
  }

  dimension: cart_viewed {
    type: yesno
    sql: ${TABLE}.cnt_cart_viewed > 0 ;;
  }


  # ----- Measures -----

  measure: avg_session_duration_minutes {
    type: average
    value_format_name: decimal_1
    sql: ${session_duration_minutes}::float ;;

    filters: {
      field: session_duration_minutes
      value: "> 0"
    }
  }

  measure: avg_tracks_per_session {
    type: average
    value_format_name: decimal_1
    sql: ${tracks_count}::float ;;
  }

  measure: count_sessions {
    type: count_distinct
    sql: ${session_id} ;;
  }


  measure: count_viewed_product {
    type: count

    filters: {
      field: product_viewed
      value: "yes"
    }
  }

  measure: count_subscribed {
    type: count

    filters: {
      field: subscribed
      value: "yes"
    }
  }

  measure: count_cart_viewed {
    type: count

    filters: {
      field: cart_viewed
      value: "yes"
    }
  }

  measure: count_product_added {
    type: count

    filters: {
      field: product_added
      value: "yes"
    }
  }

  measure: count_order_completed {
    type: count

    filters: {
      field: order_completed
      value: "yes"
    }
  }

  measure: count_checkout_started {
    type: count

    filters: {
      field: checkout_started
      value: "yes"
    }
  }

  measure: count_homepage_view {
    type: count

    filters: {
      field: homepage_view
      value: "yes"
    }
  }

  measure: count_checkout_step_completed {
    type: count

    filters: {
      field: checkout_step_completed
      value: "yes"
    }
  }
}
