- dashboard: flags
  title: Flags
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  elements:
  - title: High Priority Cases
    name: High Priority Cases
    model: vision
    explore: application
    type: looker_grid
    fields: [case.case_id, case.status, case.opened_date, case.flag, case.fips_score_average,
      case.time_open]
    filters:
      case.closed_date: 'NULL'
    sorts: [case.fips_score_average desc 0]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      case.fips_score_average: Fips Score
    series_cell_visualizations:
      case.fips_score_average:
        is_active: false
    defaults_version: 1
    title_hidden: true
    listen: {}
    row: 0
    col: 0
    width: 11
    height: 13
  - title: Case Detail
    name: Case Detail
    model: vision
    explore: application
    type: looker_single_record
    fields: [person.name, person.email_address, person.phone_number, application.previous_employer,
      application.application_id, application.ip_address, application.language, application.previous_income,
      person.ssn]
    sorts: [person.email_address]
    limit: 500
    column_limit: 50
    show_view_names: false
    series_types: {}
    defaults_version: 1
    listen:
      Untitled Filter: case.case_id
    row: 0
    col: 11
    width: 5
    height: 6
  - title: Notes
    name: Notes
    model: vision
    explore: application
    type: looker_grid
    fields: [case_events.datetime_time, case_events.datetime_date, case_events.notes,
      notes]
    filters: {}
    sorts: [case_events.datetime_time desc]
    limit: 500
    dynamic_fields: [{dimension: notes, label: Notes, expression: 'concat(${case_events.datetime_date},"
          ",${case_events.notes})', value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, _type_hint: string}]
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_column_widths:
      case_events.datetime_time: 120
    defaults_version: 1
    hidden_fields: [case_events.datetime_time, case_events.notes, case_events.datetime_date]
    listen:
      Untitled Filter: case.case_id
    row: 6
    col: 11
    width: 13
    height: 7
  - title: Locations
    name: Locations
    model: vision
    explore: application
    type: looker_map
    fields: [all_locations.location]
    filters: {}
    sorts: [all_locations.location]
    limit: 500
    column_limit: 50
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_scale_indicator: metric
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle_and_icon
    map_marker_icon_name: default
    map_marker_radius_mode: fixed
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_latitude: 37.78808138412046
    map_longitude: -96.37207031250001
    map_zoom: 3
    series_types: {}
    defaults_version: 1
    title_hidden: true
    listen:
      Untitled Filter: case.case_id
    row: 0
    col: 16
    width: 8
    height: 6
  filters:
  - name: Untitled Filter
    title: Untitled Filter
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: vision
    explore: application
    listens_to_filters: []
    field: case.case_id
