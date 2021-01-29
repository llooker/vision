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
    sql: ${TABLE}.previous_income ;;
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