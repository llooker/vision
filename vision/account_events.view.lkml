view: account_events {
  sql_table_name: `vision.account_events`
    ;;
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_id {
    type: number
    sql: ${TABLE}.event_id ;;
    primary_key: yes
  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
    value_format_name: id
  }

  dimension_group: datetime {
    type: time
    sql: ${TABLE}.datetime ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: context {
    type: string
    sql: ${TABLE}.context ;;
  }

  set: detail {
    fields: [
      event_id,
      person_id,
      datetime_time,
      ip_address,
      type,
      context
    ]
  }
}
