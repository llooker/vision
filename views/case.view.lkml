view: case {
  sql_table_name: `zekebishop-demo.ui_v3.case`
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

  dimension_group: closed_datetime {
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
    sql: ${TABLE}.closed_datetime ;;
  }

  dimension: flag_reason_code {
    type: string
    sql: ${TABLE}.flag_reason_code ;;
  }

  dimension: human_reason_code {
    type: string
    sql: ${TABLE}.human_reason_code ;;
  }

  dimension_group: opened_datetime {
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
    sql: ${TABLE}.opened_datetime ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {
    type: count
    drill_fields: [id, application.id, case_events.count]
  }
}
