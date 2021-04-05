view: feat_name_log {
  sql_table_name: `vision.feat_name_log` ;;

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

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
