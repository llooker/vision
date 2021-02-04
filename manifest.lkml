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
  label: "Vision Extension"
  url: "http://localhost:8080/bundle.js"
  entitlements: {
    local_storage: yes
    navigation: yes
    new_window: yes
    use_embeds: yes
    use_form_submit: yes
    core_api_methods: ["all_connections","search_folders", "run_inline_query", "me", "all_looks", "run_look"]
    external_api_urls: ["http://127.0.0.1:3000", "http://localhost:3000", "https://*.googleapis.com", "https://*.github.com", "https://REPLACE_ME.auth0.com"]
    oauth2_urls: ["https://accounts.google.com/o/oauth2/v2/auth", "https://github.com/login/oauth/authorize", "https://dev-5eqts7im.auth0.com/authorize", "https://dev-5eqts7im.auth0.com/login/oauth/token", "https://github.com/login/oauth/access_token"]
  }
}
