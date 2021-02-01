view: match_groups {
    derived_table: {
      sql: SELECT
        f.*,
        a.application_id
      FROM `zekebishop-demo.ui_v3.feat_fuzzy_data` f
        LEFT JOIN `zekebishop-demo.ui_v3.application` a ON (f.person_id = a.person_id)
      WHERE match_group in (
          select match_group from `zekebishop-demo.ui_v3.feat_fuzzy_data`  where person_id = 693
      )
       ;;
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
    }

    dimension: email {
      type: string
      sql: ${TABLE}.email ;;
    }

    dimension: application_id {
      type: number
      sql: ${TABLE}.application_id ;;
    }

    set: detail {
      fields: [match_group, person_id, email, application_id]
    }
  }
