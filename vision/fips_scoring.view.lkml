view: fips_scoring {
  sql_table_name: `zekebishop-demo.ui_v3.fips_scoring`;;

  dimension: application_id {
    type: number
    sql: ${TABLE}.application_id ;;
    value_format_name: id
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

  dimension: fips_id {
    type: number
    sql: ${TABLE}.fips_id ;;
  }

  dimension: fips_score {
    type: number
    sql: ${TABLE}.fips_score ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
