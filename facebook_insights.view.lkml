view: fb_insights {
  sql_table_name: FACEBOOK_ADS.INSIGHTS ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}."ID" ;;
  }

  dimension: ad_id {
    hidden: yes
    type: string
    sql: ${TABLE}."AD_ID" ;;
  }

  dimension: clicks {
    hidden: yes
    type: number
    sql: ${TABLE}."CLICKS" ;;
  }

  measure: sum_clicks {
    type: sum
    sql: ${clicks} ;;
  }

  dimension_group: date_start {
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
    sql: ${TABLE}."DATE_START" ;;
  }

#   dimension_group: date_stop {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}."DATE_STOP" ;;
#   }

#   dimension: frequency {
#     type: number
#     sql: ${TABLE}."FREQUENCY" ;;
#   }

  dimension: impressions {
    hidden: yes
    type: number
    sql: ${TABLE}."IMPRESSIONS" ;;
  }

  measure: sum_impressions {
    type: sum
    sql: ${impressions} ;;
  }

  dimension: inline_post_engagements {
    hidden: yes
    type: number
    sql: ${TABLE}."INLINE_POST_ENGAGEMENTS" ;;
  }

  measure: sum_inline_post_engagements {
    type: sum
    sql: ${inline_post_engagements} ;;
  }

  dimension: link_clicks {
    type: number
    sql: ${TABLE}."LINK_CLICKS" ;;
  }

  dimension: reach {
    type: number
    sql: ${TABLE}."REACH" ;;
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

  dimension: social_spend {
    hidden: yes
    type: number
    sql: ${TABLE}."SOCIAL_SPEND" ;;
  }

  measure: sum_social_spend {
    type: sum
    sql: ${social_spend} ;;
    value_format_name: usd_0
  }

  dimension: spend {
    hidden: yes
    type: number
    sql: ${TABLE}."SPEND" ;;
  }

  measure: sum_spend {
    type: sum
    sql: ${spend} ;;
    value_format_name: usd_0
  }

#   dimension: unique_clicks {
#     type: number
#     sql: ${TABLE}."UNIQUE_CLICKS" ;;
#   }
#
#   dimension: unique_impressions {
#     type: number
#     sql: ${TABLE}."UNIQUE_IMPRESSIONS" ;;
#   }

#   dimension_group: uuid_ts {
#     type: time
#     timeframes: [
#       raw,
#       time,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     sql: ${TABLE}."UUID_TS" ;;
#   }
#
#   measure: count {
#     type: count
#     drill_fields: [id]
#   }
 }
