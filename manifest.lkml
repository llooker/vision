project_name: "vision"

constant: fips_html {
  value: "
    {% if value <= 1 %}
    <div style=\"background: #04FE94; border-radius: 2px; color: #000; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% elsif value <= 10 %}
    <div style=\"background: #EFFE04; border-radius: 2px; color: #000; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% elsif value <= 25 %}
    <div style=\"background: #FF9C33; border-radius: 2px; color: #000; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% elsif value <= 50 %}
    <div style=\"background: #FF7433; border-radius: 2px; color: #000; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% elsif value <= 75 %}
    <div style=\"background:  #FF5B33; border-radius: 2px; color: #000; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% else %}
    <div style=\"background:  #FF3333; border-radius: 2px; color: #000; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% endif %}"
}

constant: host {
  value: "https://lookerdev.govportal.io"
}


application: ef_vision {
  url: "http://localhost:8080/bundle.js"
  entitlements: {
    local_storage: yes
    navigation: yes
    new_window: yes
    use_embeds: yes
    core_api_methods: [
      "run_inline_query",
      "lookml_model_explore",
      "create_query"
    ]
  }
}
