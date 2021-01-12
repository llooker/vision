view: person {
  sql_table_name: `zekebishop-demo.ui.Person`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: address_city {
    type: string
    sql: ${TABLE}.address_city ;;
  }

  dimension: address_county {
    type: string
    sql: ${TABLE}.address_county ;;
  }

  dimension: address_line1 {
    type: string
    sql: ${TABLE}.address_line1 ;;
  }

  dimension: address_line2 {
    type: string
    sql: ${TABLE}.address_line2 ;;
  }

  dimension: address_state {
    type: string
    sql: ${TABLE}.address_state ;;
  }

  dimension: address_zip {
    type: string
    sql: ${TABLE}.address_zip ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: application_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.application_id ;;
  }

  dimension_group: date_of_birth {
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
    sql: ${TABLE}.date_of_birth ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: head_of_household {
    type: yesno
    sql: ${TABLE}.head_of_household ;;
  }

  dimension: household_id {
    type: number
    sql: ${TABLE}.household_id ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: ssn {
    type: string
    sql: ${TABLE}.ssn ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, application.id, account_events.count]
  }
}
