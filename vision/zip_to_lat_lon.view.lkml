view: zip_to_lat_lon {
  sql_table_name: `zip_to_lat_lon`
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
    # sql: LPAD(cast(${TABLE}.Zip as string),5,'0') ;;
    sql: ${TABLE}.Zip ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}


  view: all_locations {
    derived_table: {
      sql: WITH pzip as (
        SELECT person_id,home_zip as zip FROM `vision.person`
        UNION ALL
        SELECT person_id,mail_zip FROM `vision.person`
      )
      SELECT
         pzip.*
        ,zll.Latitude
        ,zll.Longitude
      FROM pzip
        --LEFT JOIN `vision.zip_to_lat_lon` as zll ON (pzip.zip = LPAD(cast(zll.Zip as string),5,'0'))
        LEFT JOIN `vision.zip_to_lat_lon` as zll ON pzip.zip = zll.Zip
       ;;
    }

    dimension: person_id {
      hidden: yes
      type: number
      sql: ${TABLE}.person_id ;;
    }

    dimension: location {
      type: location
      sql_latitude: ${TABLE}.latitude ;;
      sql_longitude: ${TABLE}.longitude ;;
    }


  }
