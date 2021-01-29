view: case_events {
  sql_table_name: `zekebishop-demo.ui_v3.case_events` ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: case_event_id {
    type: number
    sql: ${TABLE}.case_event_id ;;
    primary_key: yes
    value_format_name: id
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}.case_id ;;
    value_format_name: id
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension_group: datetime {
    type: time
    sql: ${TABLE}.datetime ;;
  }

  set: detail {
    fields: [case_event_id, case_id, type, notes, datetime_time]
  }
}
