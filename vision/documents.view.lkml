view: documents {
  sql_table_name: `vision.documents`;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
    value_format_name: id
  }

  dimension: person_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.person_id ;;
  }

  dimension: file_location {
    type: string
    # sql:
    #   CASE
    #     WHEN ${file_type} = "drivers_license" THEN "https://storage.googleapis.com/looker-dat-vision/dl_1_Shaun_Mcdonald.jpg"
    #     ELSE ${TABLE}.file_location
    #   END
    # ;;
    sql: ${TABLE}.location ;;
  }

  dimension: file_type {
    type: string
    sql: ${TABLE}.type ;;
    link: {
      url: "{{ file_location._value }}"
      label: "View {{ value }}"
    }
  }

  dimension: verification_status {
    type: string
    sql: "Passed Application Check" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, application.id]
  }
}
