view: payments {
  sql_table_name: vision.payments;;
  drill_fields: [
     person.person_id
    ,person.name
    ,application.application_id
    ,date_date
    ,amount
  ]

  dimension: payment_id {
    type: number
    sql: ${TABLE}.payment_id ;;
    primary_key: yes
    value_format_name: id
  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
    value_format_name: id
  }

  dimension_group: date {
    type: time
    sql: ${TABLE}.date ;;
  }

  dimension: payment_number {
    type: number
    sql: ${TABLE}.payment_number ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
    value_format_name: big_money
  }

  dimension: amount_tier {
    type: tier
    sql: ${TABLE}.amount ;;
    tiers: [0, 200, 400, 600, 800, 1000]
    style: relational
  }

  measure: distribution_amount {
    type: sum
    sql: ${amount} ;;
    value_format_name: big_money
  }

  measure: median_distirbution_amount {
    type: median
    sql: ${amount} ;;
    value_format_name: usd
  }
  measure: average_distirbution_amount {
    type: average
    sql: ${amount} ;;
    value_format_name: usd
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: running_total {
    type: max
    sql: ${TABLE}.amount_total ;;
    value_format_name: usd
  }

  set: detail {
    fields: [
      payment_id,
      person_id,
      date_time,
      payment_number,
      amount,
      status
    ]
  }
}
