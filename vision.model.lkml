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
  # join: feat_fuzzy_data {
  #   view_label: "Match Groups"
  #   sql_on: ${person.person_id} = ${feat_fuzzy_data.person_id} ;;
  # }
  aggregate_table: search {
    query: {
      dimensions: [person.person_id, person._search]
      limit: 10000
    }
    materialization: {
      sql_trigger_value: select 1 ;;
    }
  }
  query: distribution_of_amounts {
    dimensions: [payments.amount_tier]
    measures: [payments.count]
    description: "See distribution of amounts"
  }
  query: prior_year_outstanding_cases_by_state{
    dimensions: [person.home_state, person.count]
    filters: [case.is_open: "Yes", case.opened_date: "before 2021-01-01"]
    description: "See outstanding cases from last year that are still open"
  }
  query: out_of_zip{
    dimensions: [person.name, person.ssn, person.phone_number, person.email_address, person.mail_zip, person.home_zip]
    measures: [application.count]
    filters: [person.matching_zip: "no"]
    description: "See persons with non matching home and mailing zip codes"
  }
}

# explore: feat_fuzzy_data {
#   view_label: "Match Groups"
#   join: person {
#     sql_on: ${feat_fuzzy_data.person_id} = ${person.person_id} ;;
#     relationship: many_to_one
#   }
# }

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


view: match_groups {
  derived_table: {
    sql:
    WITH grps as (
    SELECT rank() OVER (partition by match_feature order by match_value) as match_group, * FROM (
      select  person_id, email_address as `match_value`, 'email_match' as `match_feature`  from vision.person where
        email_address in (
          select email_address from vision.person group by 1 having count(*) > 1
        )
      union all
      select person_id, home_address,  'home_address_match' from vision.person where
        home_address in (
                select home_address  from vision.person group by 1 having count(*) > 1
              )

      union all
      select person_id, mail_address,  'mail_address_match' from vision.person where
        mail_address in (
                select mail_address  from vision.person group by 1 having count(*) > 1
              )
))
SELECT * FROM grps where
grps.match_group in (
select g.match_group from grps g where {% condition person_filter %} g.person_id {% endcondition %}
)

 ;;
  }

  filter: person_filter {
    type: number
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: match_group {
    type: number
    sql: ${TABLE}.match_group ;;
  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
    link: {
      label: "See Person"
      url: "/dashboards-next/21?Person+ID={{ value }}"
    }

  }

  dimension: match_value {
    type: string
    sql: ${TABLE}.match_value ;;
  }

  dimension: match_feature {
    type: string
    sql: ${TABLE}.match_feature ;;
  }

  set: detail {
    fields: [match_group, person_id, match_value, match_feature]
  }
}
