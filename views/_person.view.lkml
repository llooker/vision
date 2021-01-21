view: _person {
  sql_table_name: `zekebishop-demo.ui._person`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: address_city {
    type: string
    sql: ${TABLE}.address_city ;;
  }

  dimension: address_line_1 {
    type: string
    sql: ${TABLE}.address_line_1 ;;
  }

  dimension: address_state {
    type: string
    sql: ${TABLE}.address_state ;;
  }

  dimension: address_zip {
    type: zipcode
    sql: ${TABLE}.address_zip ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.loc_lat ;;
    sql_longitude:  ${TABLE}.loc_lon ;;
  }



  dimension_group: dob {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dob ;;
  }

  dimension: email_address {
    type: string
    sql: ${TABLE}.email_address ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: head_of_household {
    type: yesno
    sql: ${TABLE}.head_of_household ;;
  }

  dimension: household_id {
    type: number
    sql: ${TABLE}.household_id ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: middle_name {
    type: string
    sql: ${TABLE}.middle_name ;;
  }

  dimension: phone_number {
    type: number
    sql: ${TABLE}.phone_number ;;
    value_format: "(###) ###-####"
  }

  dimension: ssn {
    type: string
    sql: ${TABLE}.ssn ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {
    type: count
    drill_fields: [id, last_name, middle_name, first_name]
  }
  measure: household_size {
    type: count
    filters: [
      head_of_household: "no"
    ]
    required_fields: [household_id]
  }

}
