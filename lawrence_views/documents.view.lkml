view: documents {
  sql_table_name: `zekebishop-demo.ui_v3.documents`;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    value_format_name: id
  }

  dimension: application_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.application_id ;;
  }

  dimension: file_location {
    type: string
    sql: ${TABLE}.file_location ;;
    link: {
      url: "{{ value }}"
      label: "See Document"
    }
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
