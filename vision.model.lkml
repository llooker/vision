connection: "public-sector"
include: "/*/*.view.lkml"

persist_for: "0 seconds"

explore: _application {
  join: _person {
    sql_on: ${_application.household_id} = ${_person.household_id} ;;
  }
  join: _documents {
    sql_on: ${_application.id} = ${_documents.application_id} ;;
  }
  join: _case {
    sql_on: ${_application.id} = ${_case.application_id} ;;
  }
  join: _case_events {
    sql_on: ${_case.id} = ${_case_events.case_id} ;;
  }
  join: _payments {
    sql_on: ${_person.id} = ${_payments.head_of_household_id} ;;
  }
}

explore: _account_events {
  join: _person {
    sql_on: ${_account_events.person_id} = ${_person.id} ;;
  }
}

explore: application {
  label: "Lawrence Version Application"
  join: person {
    sql_on: ${application.person_id} = ${person.person_id} ;;
  }
  join: documents {
    sql_on: ${application.application_id} = ${documents.application_id} ;;
  }
  join: case {
    sql_on: ${application.application_id} = ${case.application_id} ;;
  }
  join: case_events {
    sql_on: ${case.case_id} = ${case_events.case_id} ;;
  }
  join: payments {
    sql_on: ${person.person_id} = ${payments.person_id} ;;
  }
  join: fips_scoring {
    sql_on: ${application.application_id} = ${fips_scoring.application_id} ;;
  }
  join: home_loc {
    from: zip_to_lat_lon
    view_label: "Person"
    sql_on: ${person.home_zip} = ${home_loc.zip} ;;
  }
  join: mail_loc {
    from: zip_to_lat_lon
    view_label: "Person"
    sql_on: ${person.mail_zip} = ${mail_loc.zip} ;;
  }
  join: feat_fuzzy_data {
    view_label: "Match Groups"
    sql_on: ${person.person_id} = ${feat_fuzzy_data.person_id} ;;
  }
}

explore: feat_fuzzy_data {
  view_label: "Match Groups"
  join: person {
    sql_on: ${feat_fuzzy_data.person_id} = ${person.person_id} ;;
    relationship: many_to_one
  }
}

explore: account_events {
  label: "Lawrence Version Application Events"
  join: person {
    sql_on: ${account_events.person_id} = ${person.person_id} ;;
  }
  join: application {
    sql_on: ${person.person_id} = ${application.person_id} ;;
  }
  join: case {
    sql_on: ${application.application_id} = ${case.application_id} ;;
    relationship: one_to_many
  }
}

named_value_format: big_money {
  value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
}
