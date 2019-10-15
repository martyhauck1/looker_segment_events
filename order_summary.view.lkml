view: order_summary {
  sql_table_name: LANDING_ZONE.ORDER_SUMMARY ;;

  parameter: date_granularity {
    type: string
    allowed_value: {
      label: "Order Day"
      value: "Day"
    }
    allowed_value: {
      label: "Order Week"
      value: "Week"
    }
    allowed_value: {
      label: "Order Month"
      value: "Month"
    }

  }

  parameter: date_granularity_pivot {
    type: string
    allowed_value: {
      label: "Order Day"
      value: "Day"
    }
    allowed_value: {
      label: "Order Week"
      value: "Week"
    }
    allowed_value: {
      label: "Order Month"
      value: "Month"
    }
    allowed_value: {
      label: "Order Year"
      value: "Year"
    }

  }

  parameter: date_granularity_pop {
    type: string
    allowed_value: {
      label: "Order Day"
      value: "Day"
    }
    allowed_value: {
      label: "Order Week"
      value: "Week"
    }
    allowed_value: {
      label: "Order Month"
      value: "Month"
    }
    allowed_value: {
      label: "Order Year"
      value: "Year"
    }

  }

  parameter: date_granularity_pivot_pop {
    type: string
    allowed_value: {
      label: "Order Day"
      value: "Day"
    }
    allowed_value: {
      label: "Order Week"
      value: "Week"
    }
    allowed_value: {
      label: "Order Month"
      value: "Month"
    }
    allowed_value: {
      label: "Order Year"
      value: "Year"
    }

  }



  dimension: agentid {
    hidden: yes
    type: string
    sql: ${TABLE}.agentid ;;
  }

  dimension: cobrand {
    type: string
    sql: ${TABLE}.cobrand ;;

    link: {
      label: "{{value}} Analytics Dashboard"
      url: "/dashboards/2?Cobrand={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }

  }

  dimension: coupon_name {
    label: "Coupon Name"
    type: string
    sql: ${TABLE}.coupon_name ;;
  }

  dimension: customer_id {
    hidden: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: customer_type {
    label: "Customer Type Detail"
    type: string
    sql: ${TABLE}.customer_type ;;
  }

  dimension: customer_type_basic {
    label: "Customer Type"
    description: "Groups all 'Previous' Types together"
    type: string
    sql: IFF(${TABLE}.customer_type LIKE 'Prev%','Previous',${customer_type}) ;;
  }

  dimension: email { hidden: yes
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: time_from_last_order {
    type: string
    order_by_field: time_from_last_order_sort
    sql: case when ${customer_type} = 'NEW' then '0'
        when ${customer_type} = 'PREVIOUS 0-90' then '0-90'
        when ${customer_type} = 'PREVIOUS 181-270' then '181-270'
        when ${customer_type} = 'PREVIOUS 271-365' then '271-365'
        when ${customer_type} = 'PREVIOUS 91-180' then '91-180'
        when ${customer_type} = 'REACTIVE' then '365+' else null end;;
  }

  dimension: time_from_last_order_sort {
    hidden: yes
    type: number
    sql: case when ${customer_type} = 'NEW' then 1
        when ${customer_type} = 'PREVIOUS 0-90' then 2
        when ${customer_type} = 'PREVIOUS 181-270' then 4
        when ${customer_type} = 'PREVIOUS 271-365' then 5
        when ${customer_type} = 'PREVIOUS 91-180' then 3
        when ${customer_type} = 'REACTIVE' then 6 else null end  ;;
  }

  dimension: discount {
    hidden: yes
    type: number
    sql: ${TABLE}.discount ;;
  }

  ### POS TYPE ###

  dimension: point_of_sale {
    label: "POS"
    type: string
    sql: case when ${is_tele_adj}= true then 'Phone'
          when ${TABLE}.is_mail_order = true then 'Mail'
          when ${TABLE}.is_web = true then 'Web'
          when ${TABLE}.is_auto = true then 'Auto' else null end
          ;;
  }

  dimension: is_auto {
    label: "Is Autoship"
    group_label: "POS Flag"
    type: yesno
    sql: ${TABLE}.is_auto ;;
  }

  dimension: is_mail_order {
    # hidden: yes
    group_label: "POS Flag"
    type: yesno
    sql: ${TABLE}.is_mail_order = true ;;
  }

  dimension: is_tele {
    hidden: yes
    group_label: "POS Flag"
    type: yesno
    sql: ${TABLE}.is_tele = true ;;
  }

  dimension: is_tele_adj {
    label: "Is Phone Order"
    group_label: "POS Flag"
    type:  yesno
    sql: IFF(${TABLE}.is_mail_order = true and ${TABLE}.is_tele = true, false, ${is_tele})   ;;
  }

  dimension: is_web {
    group_label: "POS Flag"
    type: yesno
    sql: ${TABLE}.is_web = true ;;
  }

  dimension: line_count {
    hidden: yes
    type: number
    sql: ${TABLE}.line_count ;;
  }

  dimension: login {
    type: string
    sql: ${TABLE}.login ;;
  }

  dimension: md5key {
    type: string
    sql: ${TABLE}.md5key ;;
  }


  dimension_group: order {
    label: " Order"
    type: time
    timeframes: [
      raw,
      date,
      week,
      day_of_week,
      day_of_month,
      month,
      month_num,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.order_date ;;
  }

  dimension: dynamic_order_date {
    type: string
    sql: case when {% parameter date_granularity %} = 'Day' then ${order_date}
              when {% parameter date_granularity %} = 'Week' then ${order_week}
              when {% parameter date_granularity %} = 'Month' then ${order_month}
              else null end;;
  }

  dimension: dynamic_order_date_pivot {
    type: string
    sql: case when {% parameter date_granularity_pivot %} = 'Day' then ${order_date}
              when {% parameter date_granularity_pivot %} = 'Week' then ${order_week}
              when {% parameter date_granularity_pivot %} = 'Month' then ${order_month}
              when {% parameter date_granularity_pivot %} = 'Year' then ${order_year}::varchar
              else null end;;
  }

  dimension: dynamic_order_date_pop {
    type: number
    sql: case when {% parameter date_granularity_pop %} = 'Day' then ${order_day_of_month}
              when {% parameter date_granularity_pop %} = 'Week' then ${order_day_of_week}
              when {% parameter date_granularity_pop %} = 'Month' then ${order_month_num}
              else null end;;
  }

  dimension: dynamic_order_date_pivot_pop {
    type: number
    sql: case when {% parameter date_granularity_pivot_pop %} = 'Day' then ${order_day_of_month}
              when {% parameter date_granularity_pivot_pop %} = 'Week' then ${order_day_of_week}
              when {% parameter date_granularity_pivot_pop %} = 'Month' then ${order_month_num}
              when {% parameter date_granularity_pivot_pop %} = 'Year' then ${order_year}::varchar
              else null end;;
  }

  dimension: orderid {
    label: "Order ID"
    primary_key: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.orderid ;;
  }

  dimension: seq {
    label: "Sequence"
    type: number
    sql: ${TABLE}.seq ;;
  }

  dimension: is_first_purchase {
    type: yesno
    sql: ${seq} = 1 ;;
  }

  dimension: shipping_discount { hidden: yes
    type: number
    sql: ${TABLE}.shipping_discount ;;
  }

  dimension: status {
    description: "F = failed, P and Q = processed, R = returned"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: tax { hidden: yes
    type: number
    sql: ${TABLE}.tax ;;
  }

  dimension: total { hidden: yes
    type: number
    sql: ${TABLE}.total ;;
  }

  dimension_group: tracking {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      day_of_month,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.tracking_date ;;
  }

#   dimension: days_to_process {
#     description: "F = failed, P and Q = processed, R = returned"
#     type: number
#     sql: case when ${status} in ('Q', 'R') then datediff(${detail_summary.ship_date}, ${order_date})*1.0
#       when ${status} = 'P' then datediff(curdate(), ${order_date})*1.0 else null end;;
#   }

  #### MEASURES ####

  measure: distinct_md5key {
    type: count_distinct
    label: "{% if  _view._name == 'order_summary' %} Unique Customers
    {% elsif  _view._name == 'repeat_purchases' %} Repeat Customers
    {% else %} Unique Customers {% endif %} "


    sql: ${md5key} ;;
  }

  measure: new_customers {
    type: count_distinct
    sql: ${orderid} ;;
    drill_fields: [customer_detail*]
    filters: {
      field: seq
      value: "1"
    }
  }

  ##where customer type = new

  measure: total_revenue {
    description: "Total Revenue includes Product Revenue, Shipping Costs & Taxes"
    label: "Total Order Revenue"
    type: sum
    sql: ${total} ;;
    value_format_name: usd_0
    drill_fields: [order_detail*]
  }

  measure: average_revenue {
    label: "Average Order Revenue"
    type: average
    value_format_name: usd_0
    sql: ${total} ;;
  }

  measure: total_gross_margin {
    description: "Total Order Revenue less COGS (at time of purchase) and Shipping Fees"
    type: number
    sql: ${total_revenue} - ${sum_cogs_then} - ${shipping_fee} ;;
    value_format_name: usd_0
    drill_fields: [order_detail*]
  }

  measure: total_auto_revenue {
    label: "Total Order Revenue - Autoship"
    type: sum
    sql: ${total} ;;
    filters: {
      field: point_of_sale
      value: "Auto"
    }
    value_format_name: usd_0
    drill_fields: [order_detail*]
  }

  measure: sum_order_bottles {
    type: sum
    label: "Total Order Bottles"
    sql: ${TABLE}.bottle_quantity ;;
  }

  measure: sum_cogs_then {
    label: "Total Order COGS"
    description: "Total COGS at time of purchase"
    type: sum
    sql: ${TABLE}.cogs_then ;;
    value_format_name: usd_0
  }

  measure: count {
    label: "Total Order Count"
    type: count
    drill_fields: [order_detail*]
  }
#
#   measure: average_days_to_process {
#     type: average
#     sql: ${days_to_process} ;;
#     drill_fields: [orderid, order_date, detail_summary.ship_date, status]
#   }

  ### SETS ###

  set: order_detail {
    fields: [orderid, order_date, point_of_sale, status, total_revenue]
  }

  set: customer_detail {
    fields: [md5key,count,total_revenue]
  }


  #### OTHER MEASURES - HIDDEN ###

  measure: avg_order_bottles { hidden: yes
    type: average
    label: "Average Order Bottles"
    sql: ${TABLE}.bottle_quantity ;;
  }

  measure: average_cogs_then { hidden: yes
    label: "Average Order COGS"
    type: average
    sql: ${TABLE}.cogs_then ;;
  }

  measure: shipping_cost {
    label: "Total Shipping Revenue"
    type: sum
    sql: ${TABLE}.shipping_cost ;;
  }

  measure: shipping_fee {
    label: "Total S&H Costs"
    type: sum
    sql: ${TABLE}.shipping_fee ;;
  }

  measure: previous_revenue  { hidden: yes
    label: "Order Revenue (Previous)"
    group_label: "Other Totals"
    type: sum
    sql: ${total} ;;
    value_format_name: usd_0
    filters: {
      field: customer_type_basic
      value: "Previous"
    }
  }

  measure: reactive_revenue  { hidden: yes
    label: "Order Revenue (Reactive)"
    group_label: "Other Totals"
    type: sum
    sql: ${total} ;;
    value_format_name: usd_0
    filters: {
      field: customer_type_basic
      value: "REACTIVE"
    }
  }

  measure: new_revenue  { hidden: yes
    label: "Order Revenue (New)"
    group_label: "Other Totals"
    type: sum
    sql: ${total} ;;
    value_format_name: usd_0
    filters: {
      field: customer_type_basic
      value: "NEW"
    }
  }

  measure: sum_cogs_now { hidden: yes
    group_label: "Other Totals"
    label: "Order COGS (Now)"
    type: sum
    sql: ${TABLE}.cogs_now ;;
  }


  measure: sum_subtotal { hidden: yes
    label: "Subtotal"
    group_label: "Other Totals"
    type: sum
    sql: ${TABLE}.subtotal ;;
  }

  # dimension: bottle_quantity {
  #   hidden: yes
  #   type: number
  #   sql: ${TABLE}.bottle_quantity ;;
  # }

  # dimension: cogs_now {
  #   hidden: yes
  #   type: number
  #   sql: ${TABLE}.cogs_now ;;
  # }

  # dimension: cogs_then {
  #   hidden: yes
  #   type: number
  #   sql: ${TABLE}.cogs_then ;;
  # }

  # dimension: subtotal {
  #   hidden: yes
  #   type: number
  #   sql: ${TABLE}.subtotal ;;
  # }

  # dimension: coupon {
  #   hidden: yes
  #   type: string
  #   sql: ${TABLE}.coupon ;;
  # }
}
