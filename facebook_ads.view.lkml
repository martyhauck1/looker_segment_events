view: fb_ads {
  sql_table_name: FACEBOOK_ADS.ADS ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."ID" ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}."ACCOUNT_ID" ;;
  }

  dimension: adset_id {
    type: string
    sql: ${TABLE}."ADSET_ID" ;;
  }

  dimension: bid_amount {
    type: number
    sql: ${TABLE}."BID_AMOUNT" ;;
  }

  dimension: bid_type {
    type: string
    sql: ${TABLE}."BID_TYPE" ;;
  }

  dimension: campaign_id {
    type: string
    # hidden: yes
    sql: ${TABLE}."CAMPAIGN_ID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
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

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: url_parameters {
    type: string
    sql: ${TABLE}."URL_PARAMETERS" ;;
  }

  dimension: utm_campaign {
    type: string
    sql: ${TABLE}."UTM_CAMPAIGN" ;;
  }

  dimension: utm_content {
    type: string
    sql: ${TABLE}."UTM_CONTENT" ;;
  }

  dimension: utm_medium {
    type: string
    sql: ${TABLE}."UTM_MEDIUM" ;;
  }

  dimension: utm_source {
    type: string
    sql: ${TABLE}."UTM_SOURCE" ;;
  }

  dimension: utm_term {
    type: string
    sql: ${TABLE}."UTM_TERM" ;;
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
    drill_fields: [id, name, campaigns.name, campaigns.id]
  }
}
