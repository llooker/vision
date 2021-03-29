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
    # sql:
    #   CASE
    #     WHEN ${file_type} = "drivers_license" THEN "https://storage.googleapis.com/looker-dat-vision/dl_1_Shaun_Mcdonald.jpg"
    #     ELSE ${TABLE}.file_location
    #   END
    # ;;
    sql: ${TABLE}.file_location ;;
  }

  dimension: file_type {
    type: string
    sql: ${TABLE}.file_type ;;
    link: {
      url: "{{ file_location._value }}"
      label: "View {{ value }}"
    }
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
