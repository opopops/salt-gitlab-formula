{%- from "gitlab/map.jinja" import gitlab with context %}

include:
  - gitlab.repo

gitlab_server_package:
  pkg.installed:
    - name: {{ gitlab.server_pkg }}
    {%- if gitlab.server.version is defined %}
    - version: {{ gitlab.server.version }}
    {%- endif %}
    {%- if gitlab.manage_repo %}
    - require:
      - sls: gitlab.repo
    {%- endif %}
