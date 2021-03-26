view: person {
  sql_table_name: `zekebishop-demo.ui_v3.person`;;

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
    primary_key: yes
    value_format_name: id
  }

  dimension_group: dob {
    group_label: "Demographics"
    type: time
    timeframes: [date,month,year]
    datatype: date
    sql: ${TABLE}.date_of_birth ;;
  }

  dimension: age {
    group_label: "Demographics"
    type: number
    sql:  DATE_DIFF(CURRENT_DATE,${dob_date}, YEAR) ;;
  }

  dimension: age_bracket {
    type: tier
    style: integer
    sql: ${age} ;;
    tiers: [10,18,21,34,40,50,65,75]
    group_label: "Demographics"
  }

  dimension: gender {
    group_label: "Demographics"
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: home_address {
    type: string
    sql: ${TABLE}.home_address ;;
    group_label: "Home Address"
  }

  dimension: home_city {
    type: string
    sql: ${TABLE}.home_city ;;
    group_label: "Home Address"
  }

  dimension: home_state {
    type: string
    sql: ${TABLE}.home_state ;;
    group_label: "Home Address"
  }

  dimension: home_zip {
    type: zipcode
    sql: ${TABLE}.home_zip ;;
    group_label: "Home Address"
  }

  dimension: mail_address {
    type: string
    sql: ${TABLE}.mail_address ;;
    group_label: "Mailing Address"
  }

  dimension: mail_city {
    type: string
    sql: ${TABLE}.mail_city ;;
    group_label: "Mailing Address"
  }

  dimension: mail_state {
    type: string
    sql: ${TABLE}.mail_state ;;
    group_label: "Mailing Address"
  }

  dimension: mail_zip {
    type: string
    sql: ${TABLE}.mail_zip ;;
    group_label: "Mailing Address"
  }

  dimension: language {
    group_label: "Demographics"
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: _search {
    # hidden: yes
    sql: CONCAT(
                ${name},
                ' Email: ',${email_address},
                ' Phone: ',${phone_number},
                ' SSN: ',${ssn}) ;;
  }

  dimension: ssn {
    group_label: "PII"
  }

  dimension: email_address {
    group_label: "PII"
  }

  dimension: phone_number {
    type: number
    group_label: "PII"
    value_format: "(###) ###-####"
  }

  dimension: name {
    group_label: "Name (PII)"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: first_name {
    group_label: "Name (PII)"
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    group_label: "Name (PII)"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      person_id,
      name,
      dob_date,
      gender,
      home_address,
      home_city,
      home_state,
      home_zip,
      mail_address,
      mail_city,
      mail_state,
      mail_zip,
      language,
      first_name,
      last_name
    ]
  }
}
