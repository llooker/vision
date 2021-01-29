view: zip_to_lat_lon {
  sql_table_name: `zekebishop-demo.ui_v3.zip_to_lat_lon`
    ;;

  dimension: latitude {
    hidden: yes
    type: number
    sql: ${TABLE}.Latitude ;;
  }

  dimension: longitude {
    hidden: yes
    type: number
    sql: ${TABLE}.Longitude ;;
  }

  dimension: location {
    type: location
    group_label: "{% if _view._name == 'home_loc' %}Home Address{% elsif _view._name == 'mail_loc'%}Mailing Address{% endif %}"
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: zip {
    hidden: yes
    primary_key: yes
    type: zipcode
    sql: LPAD(cast(${TABLE}.Zip as string),5,'0') ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
