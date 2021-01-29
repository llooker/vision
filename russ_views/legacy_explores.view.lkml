include: "/vision.model.lkml"
explore: _application {
  hidden: yes
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
  hidden: yes
  join: _person {
    sql_on: ${_account_events.person_id} = ${_person.id} ;;
  }
}
