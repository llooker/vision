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
    # link: {
    #   label: "See Person"
    #   url: "@{host}/embed/dashboards-next/21?Person+ID={{ value }}"
    # }
    link: {
      label: "View Beneficiary"
      # url: "/dashboards-next/21?Person+ID={{ person_id._value }}"
      url: "{{ person_id._value }}"
    }
    # link: {
    #   label: "See Driver's License"
    #   url: "/explore/vision/application?fields=documents.file_location&f[documents.file_type]=%22drivers_license%22&f[person.person_id]={{ value }}&sorts=documents.file_location&limit=500&column_limit=50&vis=%7B%22hidden_fields%22%3A%5B%5D%2C%22hidden_points_if_no%22%3A%5B%5D%2C%22series_labels%22%3A%7B%7D%2C%22show_view_names%22%3Atrue%2C%22series_types%22%3A%7B%7D%2C%22type%22%3A%22marketplace_viz_carousel%3A%3Acarousel-marketplace%22%2C%22defaults_version%22%3A0%7D&filter_config=%7B%22documents.file_type%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22drivers_license%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%2C%22person.person_id%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22811%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded"
    # }

    link: {
      url: "{{ documents.file_location._value }}"
      label: "See Driver's License"
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
