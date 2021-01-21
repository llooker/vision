connection: "public-sector"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

explore: person {}

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
  join: _payments {
    sql_on: ${_person.id} = ${_payments.head_of_household_id} ;;
  }
}

explore: _account_events {
  join: _person {
    sql_on: ${_account_events.person_id} = ${_person.id} ;;
  }



}
