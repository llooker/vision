view: _case {
  sql_table_name: `zekebishop-demo.ui._case`;;
  drill_fields: [id, application_id, status, reason_code, opened_time, closed_time]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    value_format_name: id
    action: {
      label: "Add Notes"
      url: "https://us-central1-vision-302704.cloudfunctions.net/vision_add_case_notes"
      # url: "https://visiontestfoo.free.beeceptor.com"
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
    action: {
      label: "Change Status"
      url: "https://us-central1-vision-302704.cloudfunctions.net/vision_change_case_status"
      # url: "https://visiontestfoo.free.beeceptor.com"
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
  }

  dimension: application_id {
    type: number
    sql: ${TABLE}.application_id ;;
  }

  dimension_group: closed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.closed_date ;;
  }

  dimension_group: opened {
    type: time
    timeframes: [
      raw,
      date,
      time,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opened_date ;;
  }

  dimension: reason_code {
    type: string
    sql: ${TABLE}.reason_code ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    html:
    {% if value == 'pending' %}
    <div style="background: #FBB555; border-radius: 2px; color: #000; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'Unsatisfied' %}
        <div style="background: #FBB555; border-radius: 2px; color: #000; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'closed_with_no_action' %}
    <div style="background: #c9daf2; border-radius: 2px; color: #000; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'closed_with_no_action' %}
    <div style="background: #8BC34A; border-radius: 2px; color: #000; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% elsif value == 'closed_with_action' %}
    <div style="background:  #8BC34A; border-radius: 2px; color: #000; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;">{{ rendered_value }}</div>
    {% endif %}

    ;;
  }

  measure: count {
    type: count
  }
}
