view: product_viewed {
  sql_table_name: SAN_WEBSITE_PROD.PRODUCT_VIEWED ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."ID" ;;
  }

  dimension: anonymous_id {
    type: string
    sql: ${TABLE}."ANONYMOUS_ID" ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}."BRAND" ;;
  }

  dimension: cart_id {
    type: string
    sql: ${TABLE}."CART_ID" ;;
  }

  dimension: category {
    type: number
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: context_campaign_content {
    type: string
    sql: ${TABLE}."CONTEXT_CAMPAIGN_CONTENT" ;;
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

  dimension: context_campaign_term {
    type: string
    sql: ${TABLE}."CONTEXT_CAMPAIGN_TERM" ;;
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

  dimension: event {
    type: string
    sql: ${TABLE}."EVENT" ;;
  }

  dimension: event_text {
    type: string
    sql: ${TABLE}."EVENT_TEXT" ;;
  }

  dimension: image_url {
    type: string
    sql: ${TABLE}."IMAGE_URL" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
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

  dimension: price {
    type: number
    sql: ${TABLE}."PRICE" ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}."PRODUCT_ID" ;;
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

  dimension: sku {
    type: string
    sql: ${TABLE}."SKU" ;;
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

  dimension: url {
    type: string
    sql: ${TABLE}."URL" ;;
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
    drill_fields: [id, context_campaign_name, context_library_name, name]
  }
}
