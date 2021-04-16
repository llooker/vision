# connection: "public-sector"
connection: "public-sector-pbl-demo"
include: "/*/*.view.lkml"
persist_for: "0 minute"


explore: application {
  join: person {
    sql_on: ${application.person_id} = ${person.person_id} ;;
  }
  join: documents {
    sql_on: ${application.person_id} = ${documents.person_id} ;;
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
  aggregate_table: search {
    query: {
      dimensions: [person.person_id, person._search]
      limit: 10000
    }
    materialization: {
      sql_trigger_value: select 1 ;;
    }
  }

# open cases
  query: open_cases {
    dimensions: [case.case_id, case.flag, case.judgement, case.opened_date, person.name]
    measures: [case.fips_score_]
    filters: [
      case.is_open: "Yes",
      case.opened_date: "NOT NULL"
    ]
    description: "View the whole open case queue"
  }
# Beneficiaries by open cases

    query: beneficiaries_with_open_cases {
      dimensions: [person.name, person.person_id]
      measures: [case.fips_score_max, person.cases]
      filters: [
        case.flag: "-NULL,-EMPTY",
        case.is_open: "Yes"
      ]
      description: "View Beneficiaries with open cases"
    }

# aging cases
  query: aging_cases {
      dimensions: [
        case.case_id,
        case.created_by,
        case.flag,
        case.opened_date,
        case.status,
        case.time_open,
        person.first_name,
        person.last_name
      ]
      measures: [case.fips_score_average]
      filters: [
        case.closed_date: "NULL",
        case.time_open: ">90"
      ]
    description: "View cases open longer than 90 days"
    }
# out of state addresses
  query: out_of_state_mail_address {
    dimensions: [person.home_address_full, person.mail_address_full, person.name, person.person_id]
    measures: [person.cases]
    filters: [person.mail_state: "-CA"]
    description: "Beneficiaries with mailing addresses outside of the state (and any cases)"
  }

# marked suspicious IP
  query: suspicious_ip_addresses {
    dimensions: [ip_address, person.name, person.person_id]
    measures: [person.cases]
    filters: [application.ip_address: "10.%,1.%,192%"]
    description: "Beneficiaries with suspicious IP addresses patterns (and any cases)"
  }



  case_sensitive: no
}


explore: match_groups {
  label: "AI Match Groups"
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
  join: payments {
    sql_on: ${person.person_id} = ${payments.person_id} ;;
  }
}

named_value_format: big_money {
  value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
}
