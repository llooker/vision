connection: "public-sector"
include: "/*/*.view.lkml"

persist_for: "1 minute"


explore: application {
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
  join: all_locations {
    sql_on: ${person.person_id} = ${all_locations.person_id} ;;
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
  label: "Application Events"
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
