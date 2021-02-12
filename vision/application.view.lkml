view: application {
  sql_table_name: `zekebishop-demo.ui_v3.application`
    ;;

  dimension: application_id {
    type: number
    sql: ${TABLE}.application_id ;;
    primary_key: yes
    value_format_name: id
    action: {
      label: "Create Case"
      url: "https://us-central1-vision-302704.cloudfunctions.net/create_case"
      # url: "https://kewl1.proxy.beeceptor.com"
      form_param: {
        name: "reason_code"
        label: "Reason Code"
        type: select
        default: "human_suspicious_email"
        option: {
          name: "human_suspicious_email"
          label: "Suspicious Email"
        }
        option: {
          name: "human_document_mismatch"
          label: "Document Mismatch"
        }
        option: {
          name: "human_login_behavior"
          label: "Login Behavior"
        }
        option: {
          name: "duplicate_enrollments"
          label: "Duplicate Enrollments"
        }
        option: {
          name: "human_multiple_head_of_household"
          label: "Multiple Head of Household one Address"
        }
        option: {
          name: "human_eligibility_fact_change"
          label: "Facts Changing in Multiple Applications"
        }
      }
      param: {
        name: "application_id"
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
      # url: "/dashboards-next/22?Application+ID={{ value }}"
      url: "{{ value }}"
    }
    link: {
      label: "View Beneficiary"
      # url: "/dashboards-next/21?Person+ID={{ person_id._value }}"
      url: "{{ person_id._value }}"
    }
  }

  dimension: create_case {
    sql: ${application_id} ;;
    html:
      <button type="button" class="btn btn-danger" style="color:#fff;"><a href="#drillmenu" target="_self">Create Case</a></button>
    ;;
    action: {
      label: "Create Case"
      url: "https://us-central1-vision-302704.cloudfunctions.net/create_case"
      # url: "https://kewl1.free.beeceptor.com"
      form_param: {
        name: "reason_code"
        label: "Reason Code"
        type: select
        default: "human_suspicious_email"
        option: {
          name: "human_suspicious_email"
          label: "Suspicious Email"
        }
        option: {
          name: "human_document_mismatch"
          label: "Document Mismatch"
        }
        option: {
          name: "human_login_behavior"
          label: "Login Behavior"
        }
        option: {
          name: "duplicate_enrollments"
          label: "Duplicate Enrollments"
        }
        option: {
          name: "human_multiple_head_of_household"
          label: "Multiple Head of Household one Address"
        }
        option: {
          name: "human_eligibility_fact_change"
          label: "Facts Changing in Multiple Applications"
        }
      }
      param: {
        name: "application_id"
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


  dimension: status {
    #make this light green html
    sql: 'Approved' ;;

  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
    value_format_name: id
  }

  dimension_group: created_datetime {
    type: time
    sql: ${TABLE}.created_datetime ;;
  }

  dimension: previous_employer {
    type: string
    sql: ${TABLE}.previous_employer ;;
  }

  dimension: previous_income {
    type: number
    hidden: yes
    sql: ${TABLE}.previous_income ;;
    value_format_name: usd_0
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: previous_annual_income {
    type: sum
    sql: ${previous_income} ;;
    value_format_name: usd_0
  }

  measure: payments_to_previous_income_ratio {
    type: number
    sql: ${payments.average_distirbution_amount} / (${previous_annual_income}/12) ;;
    value_format_name: percent_1
  }

  set: detail {
    fields: [
      application_id,
      person_id,
      created_datetime_time,
      previous_employer,
      previous_income,
      language,
      ip_address
    ]
  }
}
