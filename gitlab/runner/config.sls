{%- from "gitlab/map.jinja" import gitlab with context %}

include:
  - gitlab.runner.install
  - gitlab.runner.service

gitlab_runner_register:
  cmd.run:
    - env:
        CI_SERVER_URL: {{ gitlab.runner.config.url }}
        RUNNER_NAME: {{ gitlab.runner.config.name }}
        REGISTRATION_TOKEN: {{ gitlab.runner.config.registration_token }}
        REGISTER_NON_INTERACTIVE: true
    {%- if gitlab.runner.config.get('executor', 'shell') == 'docker' %}
    - name: gitlab-runner register --executor docker --docker-image {{ gitlab.runner.config.docker.get('image', 'alpine:latest') }}
    {%- else %}
    - name: gitlab-runner register --executor shell
    {%- endif %}
    - unless: gitlab-runner list 2>&1 | tail -n -1 | grep -E '^{{ gitlab.runner.config.name }}[ ]+'

gitlab_runner_config:
  file.managed:
    - name: {{ gitlab.runner_config }}
    - source: salt://gitlab/files/runner/config.toml.jinja
    - template: jinja
    - makedirs: True
    - user: root
    - group: root
    - mode: 600
    - require:
      - cmd: gitlab_runner_register
    - watch_in:
      - service: gitlab_runner_service