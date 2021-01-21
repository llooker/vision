view: documents {
  sql_table_name: `zekebishop-demo.ui.Documents`
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

  dimension: file_location {
    type: string
    sql: ${TABLE}.file_location ;;
  }

  dimension: file_type {
    type: string
    sql: ${TABLE}.file_type ;;
  }

  dimension: verification_status {
    type: string
    sql: ${TABLE}.verification_status ;;
  }

  measure: count {
    type: count
    drill_fields: [id, application.id]
  }
}