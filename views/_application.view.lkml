view: _application {
  sql_table_name: `zekebishop-demo.ui._application`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    value_format_name: id
    action: {
      label: "Create Case"
      url: "https://us-central1-vision-302704.cloudfunctions.net/create_case"
      # url: "https://visiontestfoo.free.beeceptor.com"
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

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: household_id {
    type: number
    sql: ${TABLE}.household_id ;;
  }

  dimension: household_size {
    type: number
    sql: ${TABLE}.household_size ;;
  }

  dimension: ip_address_at_submit {
    type: string
    sql: ${TABLE}.ip_address_at_submit ;;
  }

  dimension: number_of_dependents {
    type: number
    sql: ${TABLE}.number_of_dependents ;;
  }

  dimension: previous_employer {
    type: string
    sql: ${TABLE}.previous_employer ;;
  }

  dimension: previous_income {
    type: number
    sql: ${TABLE}.previous_income ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
