view: application {
  sql_table_name: `zekebishop-demo.ui.Application`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: head_of_household_id {
    type: number
    sql: ${TABLE}.head_of_household_id ;;
  }

  dimension: household_id {
    type: number
    sql: ${TABLE}.household_id ;;
  }

  dimension: household_size {
    type: number
    sql: ${TABLE}.household_size ;;
  }

  dimension: ip_address_at_submit {
    type: string
    sql: ${TABLE}.ip_address_at_submit ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: number_of_dependents {
    type: number
    sql: ${TABLE}.number_of_dependents ;;
  }

  dimension: previous_employer {
    type: string
    sql: ${TABLE}.previous_employer ;;
  }

  dimension: previous_income {
    type: number
    sql: ${TABLE}.previous_income ;;
  }

  measure: count {
    type: count
    drill_fields: [id, account_events.count, person.count, case.count, documents.count]
  }
}
