project_name: "vision"

constant: fips_html {
  value: "
    {% if value <= 1 %}
    <div style=\"background: #D3FFD3; border-radius: 2px; color: #2d922d; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% elsif value <= 10 %}
    <div style=\"background: #D3FFD3; border-radius: 2px; color: #2d922d; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% elsif value <= 25 %}
    <div style=\"background: #D3FFD3; border-radius: 2px; color: #2d922d; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% elsif value <= 50 %}
    <div style=\"background: #ffd3d3; border-radius: 2px; color: #922d2d; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% elsif value <= 75 %}
    <div style=\"background:  #ffd3d3; border-radius: 2px; color: #922d2d; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% else %}
    <div style=\"background:  #ffd3d3; border-radius: 2px; color: #922d2d; display: inline-block; font-size: 11px; font-weight: bold; line-height: 1; padding: 3px 4px; width: 100%; text-align: center;\">{{ rendered_value }}</div>
    {% endif %}"
}

constant: host {
  value: "https://lookerdev.govportal.io"
}


application: ef_vision {
  label: "Vision Extension"
  url: "http://localhost:8080/bundle.js"
  # file: "bundle.js"
  entitlements: {
    local_storage: yes
    navigation: yes
    new_window: yes
    use_embeds: yes
    use_form_submit: yes
    core_api_methods: ["all_connections","search_folders", "run_inline_query", "me", "all_looks", "run_look"]
    external_api_urls: ["http://127.0.0.1:3000", "http://localhost:3000", "https://*.googleapis.com", "https://*.github.com", "https://REPLACE_ME.auth0.com","https://dat.dev.looker.com:19999", "http://localhost:8080", "https://pbldev.looker.com","https://kewl1.free.beeceptor.com"]
    oauth2_urls: ["https://accounts.google.com/o/oauth2/v2/auth", "https://github.com/login/oauth/authorize", "https://dev-5eqts7im.auth0.com/authorize", "https://dev-5eqts7im.auth0.com/login/oauth/token", "https://github.com/login/oauth/access_token"]
  }
}


visualization: {
  id: "custom_force_directed"
  # url: "https://localhost:4443/forcedirected.js"
  file: "forcedirected.js"
  label: "custom_force_directed"
}

visualization: {
  id: "kewl"
  url: "https://localhost:4443/kewl.js"
  # file: "kewl.js"
  label: "kewl"
}
