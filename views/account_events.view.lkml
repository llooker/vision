view: account_events {
  sql_table_name: `zekebishop-demo.ui.Account_Events`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: application_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.application_id ;;
  }

  dimension: context {
    type: string
    sql: ${TABLE}.context ;;
  }

  dimension_group: datetime {
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
    sql: ${TABLE}.datetime ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: person_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.person_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [id, application.id, person.last_name, person.id, person.first_name]
  }
}
