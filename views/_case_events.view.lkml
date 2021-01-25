view: _case_events {
  sql_table_name: `zekebishop-demo.ui._case_events`
    ;;
  drill_fields: [id, case_id,date_time, notes]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    value_format_name: id
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}.case_id ;;
  }

  dimension_group: date {
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
    sql: CAST(${TABLE}.date as timestamp) ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  measure: count {
    type: count
  }
}
