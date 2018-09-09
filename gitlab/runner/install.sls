{%- from "gitlab/map.jinja" import gitlab with context %}

include:
  - gitlab.repo

gitlab_runner_package:
  pkg.installed:
    - name: {{ gitlab.runner_pkg }}
    {%- if gitlab.runner.version is defined %}
    - version: {{ gitlab.runner.version }}
    {%- endif %}
    {%- if gitlab.manage_repo %}
    - require:
      - sls: gitlab.repo
    {%- endif %}
