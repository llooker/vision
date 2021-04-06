view: case_events {
  sql_table_name:
    (SELECT * FROM `vision.case_events`
  WHERE opened_by in (
            "AI", "ron@govportal.io","sal@govportal.io",
            "anil@govportal.io","desmond@govportal.io","salma@govportal.io",
            "tess@govportal.io","max@govportal.io","susan@govportal.io","{{ _user_attributes['email'] }}"
            ))
  ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: case_event_id {
    type: number
    sql: ${TABLE}.case_event_id ;;
    primary_key: yes
    value_format_name: id
  }

  dimension: case_id {
    type: number
    sql: ${TABLE}.case_id ;;
    value_format_name: id
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension_group: datetime {
    type: time
    sql: ${TABLE}.datetime ;;
  }

  set: detail {
    fields: [case_event_id, case_id, type, notes, datetime_time]
  }
}
