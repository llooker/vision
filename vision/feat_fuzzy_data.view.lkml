view: feat_fuzzy_data {
  sql_table_name: `zekebishop-demo.ui_v3.feat_fuzzy_data`;;

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: match_group {
    type: number
    sql: ${TABLE}.match_group ;;
  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
