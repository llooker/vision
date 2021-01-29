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

view: all_locations {
  derived_table: {
    sql: {% assign bounds = 0.3 %}
    WITH pzip as (
        SELECT person_id,home_zip as zip, 'home' as type FROM `zekebishop-demo.ui_v3.person`
        UNION ALL
        SELECT person_id,mail_zip, 'mail' as type FROM `zekebishop-demo.ui_v3.person`
      )
      , pzip_person as (
      SELECT
         pzip.person_id
        ,zll.Latitude
        ,zll.Longitude
        ,pzip.type
        ,STRUCT (
          STRUCT(
            zll.Latitude - {{ bounds }} as latitude
          , zll.Longitude - {{ bounds }} as longitude
          ) as xx,
          STRUCT (
            zll.Latitude + {{ bounds }} as latitude
          , zll.Longitude + {{ bounds }} as longitude
          ) as yy
        ) as bounds
      FROM pzip
        LEFT JOIN `zekebishop-demo.ui_v3.zip_to_lat_lon` as zll ON (pzip.zip = LPAD(cast(zll.Zip as string),5,'0'))
      ), bounded as (
      SELECT
          pzip_person.person_id
        , pzip_person.Latitude
        , pzip_person.Longitude
        , pzip_person.type as type
      FROM pzip_person
      UNION ALL
      SELECT
        pzip_person.person_id
      , MIN(pzip_person.bounds.xx.latitude) as latitude
      , MIN(pzip_person.bounds.xx.longitude) as longitude
      , 'xx'
      FROM pzip_person
      GROUP BY 1
      HAVING COUNT(DISTINCT CONCAT(pzip_person.latitude, pzip_person.longitude)) != 2
      UNION ALL
            SELECT
        pzip_person.person_id
      , MAX(pzip_person.bounds.yy.latitude) as latitude
      , MAX(pzip_person.bounds.yy.longitude) as longitude
      , 'yy'
      FROM pzip_person
      GROUP BY 1
      HAVING COUNT(DISTINCT CONCAT(pzip_person.latitude, pzip_person.longitude)) != 2

    )
    SELECT * FROM bounded
       ;;
  }

  dimension: person_id {
    hidden: yes
    type: number
    sql: ${TABLE}.person_id ;;
  }

  measure: lat_long_distinct {
    type: count_distinct
    sql: CONCAT(${TABLE}.latitude, ${TABLE}.longitude) ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }
  dimension: type {}
  dimension: type_value {
    type: yesno
    sql: ${type} IN ('xx','yy') ;;
  }
  measure: pixels {
    type: number
    sql: MAX(CASE WHEN ${type_value} THEN 0 ELSE 35 END) ;;
  }


}
