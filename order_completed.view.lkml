view: order_completed {
  sql_table_name: SAN_WEBSITE_PROD.ORDER_COMPLETED ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."ID" ;;
  }

  dimension: affiliation {
    type: string
    sql: ${TABLE}."AFFILIATION" ;;
  }

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}."ANONYMOUS_ID" ;;
  }

  dimension: context_campaign_medium {
    type: string
    sql: ${TABLE}."CONTEXT_CAMPAIGN_MEDIUM" ;;
  }

  dimension: context_campaign_name {
    type: string
    sql: ${TABLE}."CONTEXT_CAMPAIGN_NAME" ;;
  }

  dimension: context_campaign_source {
    type: string
    sql: ${TABLE}."CONTEXT_CAMPAIGN_SOURCE" ;;
  }

  dimension: context_campaign_unptid {
    type: string
    sql: ${TABLE}."CONTEXT_CAMPAIGN_UNPTID" ;;
  }

  dimension: context_ip {
    type: string
    sql: ${TABLE}."CONTEXT_IP" ;;
  }

  dimension: context_library_name {
    type: string
    sql: ${TABLE}."CONTEXT_LIBRARY_NAME" ;;
  }

  dimension: context_library_version {
    type: string
    sql: ${TABLE}."CONTEXT_LIBRARY_VERSION" ;;
  }

  dimension: context_page_path {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_PATH" ;;
  }

  dimension: context_page_referrer {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_REFERRER" ;;
  }

  dimension: context_page_search {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_SEARCH" ;;
  }

  dimension: context_page_title {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_TITLE" ;;
  }

  dimension: context_page_url {
    type: string
    sql: ${TABLE}."CONTEXT_PAGE_URL" ;;
  }

  dimension: context_protocols_source_id {
    type: string
    sql: ${TABLE}."CONTEXT_PROTOCOLS_SOURCE_ID" ;;
  }

  dimension: context_protocols_violations {
    type: string
    sql: ${TABLE}."CONTEXT_PROTOCOLS_VIOLATIONS" ;;
  }

  dimension: context_user_agent {
    type: string
    sql: ${TABLE}."CONTEXT_USER_AGENT" ;;
  }

  dimension: coupon {
    type: string
    sql: ${TABLE}."COUPON" ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}."CURRENCY" ;;
  }

  dimension: discount {
    type: number
    sql: ${TABLE}."DISCOUNT" ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}."EVENT" ;;
  }

  dimension: event_text {
    type: string
    sql: ${TABLE}."EVENT_TEXT" ;;
  }

  dimension: order_id {
    type: string
    sql: ${TABLE}."ORDER_ID" ;;
  }


  measure: count_orderid {
    type: count_distinct
    sql: ${order_id} ;;
  }


  dimension_group: original_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."ORIGINAL_TIMESTAMP" ;;
  }

  dimension: products {
    type: string
    sql: ${TABLE}."PRODUCTS" ;;
  }

  dimension_group: received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RECEIVED_AT" ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}."REVENUE" ;;
  }

  dimension_group: sent {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SENT_AT" ;;
  }

  dimension: shipping {
    type: number
    sql: ${TABLE}."SHIPPING" ;;
  }

  dimension: tax {
    type: number
    sql: ${TABLE}."TAX" ;;
  }

  dimension_group: timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."TIMESTAMP" ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}."TOTAL" ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension_group: uuid_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."UUID_TS" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, context_library_name, context_campaign_name]
  }
}
