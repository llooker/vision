view: case {
  sql_table_name: `zekebishop-demo.ui_v3.case`
    ;;

  dimension: case_id {
    type: number
    sql: ${TABLE}.case_id ;;
    value_format_name: id
    primary_key: yes
    action: {
      label: "Add Notes"
      # url: "https://us-central1-pbl-demo-2020-281322.cloudfunctions.net/add_case_notes"
      url: "https://ewarreng.free.beeceptor.com"
      form_param: {
        name: "case_notes"
        label: "Case Notes"
        type: textarea
      }
      param: {
        name: "case_id"
        value: "{{ value }}"
      }
      param: {
        name: "security_key"
        value: "s9cz6i9j6q4sj9nwj4"
      }

      param: {
        name: "security_key"
        value: "s9cz6i9j6q4sj9nwj4"
      }
      user_attribute_param: {
        user_attribute: email
        name: "email"
      }
    }
    action: {
      label: "Change Status"
      url: "https://us-central1-pbl-demo-2020-281322.cloudfunctions.net/change_case_status"
      form_param: {
        name: "case_status"
        label: "Change Case Status"
        type: select
        option: {
          name: "closed"
          label: "Closed"
        }
        option: {
          name: "pending"
          label: "Open"
        }
      }
      param: {
        name: "case_id"
        value: "{{ value }}"
      }
      param: {
        name: "security_key"
        value: "s9cz6i9j6q4sj9nwj4"
      }
      user_attribute_param: {
        user_attribute: email
        name: "email"
      }
    }
    link: {
      label: "View Application"
      url: "@{host}/embed/dashboards-next/22?Application+ID={{ application_id._value }}&_theme=vision_theme&embed_domain=https://govportal.io&sdk=2"
    }
  }

  dimension: is_open {
    type: yesno
    sql: ${closed_date} IS NULL ;;

  }

  dimension: action_case {
    sql: ${case_id} ;;
    html:
      <button type="button" style="color:#fff; background-color:#6c8cdc;  margin:5px;" ><a href="#drillmenu" target="_self">Action Case</a></button>
    ;;
    action: {
      label: "Change Status"
      url: "https://us-central1-pbl-demo-2020-281322.cloudfunctions.net/change_case_status"
      form_param: {
        name: "case_status"
        label: "Change Case Status"
        type: select
        option: {
          name: "closed"
          label: "Closed"
        }
        option: {
          name: "pending"
          label: "Open"
        }
      }
      param: {
        name: "case_id"
        value: "{{ case_id._value }}"
      }
      param: {
        name: "security_key"
        value: "s9cz6i9j6q4sj9nwj4"
      }
      user_attribute_param: {
        user_attribute: email
        name: "email"
      }
    }
    action: {
      label: "Add Notes"
      # url: "https://us-central1-pbl-demo-2020-281322.cloudfunctions.net/add_case_notes"
      url: "https://ewarreng.free.beeceptor.com"
      form_param: {
        name: "case_notes"
        label: "Case Notes"
        type: textarea
      }
      param: {
        name: "case_id"
        value: "{{ value }}"
      }
      param: {
        name: "security_key"
        value: "s9cz6i9j6q4sj9nwj4"
      }
      user_attribute_param: {
        user_attribute: email
        name: "email"
      }
    }
  }

  dimension: application_id {
    type: number
    sql: ${TABLE}.application_id ;;
    value_format_name: id
  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
    value_format_name: id
  }

  dimension_group: opened {
    type: time
    datatype: timestamp
    sql: ${TABLE}.opened_datetime ;;
  }

  dimension_group: closed {
    type: time
    datatype: timestamp
    sql: ${TABLE}.closed_datetime ;;
  }

  dimension: flag_reason_code {
    label: "AI Flag"
    type: string
    sql: ${TABLE}.flag_reason_code ;;
  }

  dimension: human_reason_code {
    label: "User Flag"
    type: string
    sql:  ${TABLE}.human_reason_code ;;
  }

  dimension: created_by {
    sql: ${TABLE}.opened_by ;;
  }

  dimension: flag {
    sql:
      CASE
        WHEN ${case.flag_reason_code} IS NULL THEN ${case.human_reason_code}
        ELSE ${case.flag_reason_code}
      END
    ;;
    label: "All Flags"
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: fips_score {
    hidden: yes
    type: number
    sql: ${TABLE}.fips_score ;;
    html: @{fips_html} ;;
  }

  dimension: time_open {
    type: number
    sql:
        CASE
          WHEN ${closed_date} IS NULL THEN DATE_DIFF(CURRENT_DATE,${opened_date}, DAY)
          ELSE DATE_DIFF(${closed_date},${opened_date}, DAY)
        END
    ;;
    html: {{rendered_value}} Days ;;
  }

  dimension: time_open_tier {
    type: tier
    style: integer
    sql: ${time_open} ;;
    tiers: [30,60,90,120,365]
    html: {{rendered_value}} Days ;;
  }

  measure: fips_score_max {
    group_label: "Fraud Score"
    type: max
    sql: ${fips_score} ;;
    value_format_name: decimal_1
    html: @{fips_html} ;;
  }

  measure: fips_score_min {
    group_label: "Fraud Score"
    type: min
    sql: ${fips_score} ;;
    value_format_name: decimal_1
    html: @{fips_html} ;;
  }

  measure: fips_score_average {
    group_label: "Fraud Score"
    type: average
    sql: ${fips_score} ;;
    value_format_name: decimal_1
    html: @{fips_html} ;;
  }

  measure: fips_score_median {
    group_label: "Fraud Score"
    type: median
    sql: ${fips_score} ;;
    value_format_name: decimal_1
    html: @{fips_html} ;;
  }

  measure: fips_score_ {
    label: "Fips Score"
    group_label: "Fraud Score"
    description: "Shows the individual case's Fips Score"
    type: sum
    sql: ${fips_score} ;;
    value_format_name: decimal_1
    html: @{fips_html} ;;
    required_fields: [case_id]
  }

  measure: median_time_open {
    type: median
    sql: ${time_open} ;;
    html: {{rendered_value}} Days ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  drill_fields: [detail*]
  set: detail {
    fields: [
      case_id,
      application_id,
      person_id,
      opened_date,
      closed_date,
      flag_reason_code,
      human_reason_code,
      status,
      fips_score
    ]
  }
}
