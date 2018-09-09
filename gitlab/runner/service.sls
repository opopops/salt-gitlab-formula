{%- from "gitlab/map.jinja" import gitlab with context %}

include:
  - gitlab.runner.install

gitlab_runner_service:
  service.running:
    - name: {{ gitlab.runner_service }}
    - enable: True
    - require:
        - pkg: gitlab_runner_package
