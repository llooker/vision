view: feat_domain_date {
  sql_table_name: `zekebishop-demo.ui_v3.feat_domain_date`;;

  dimension: domain {
    type: string
    sql: ${TABLE}.domain ;;
  }

  dimension: domain_group {
    type: number
    sql: ${TABLE}.domain_group ;;
  }

  dimension_group: registration {
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
    sql: ${TABLE}.registration ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
