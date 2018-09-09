{%- from "gitlab/map.jinja" import gitlab with context %}

include:
  - gitlab.repo
  - gitlab.server.install
  - gitlab.server.ssl
  - gitlab.server.config
  - gitlab.server.service
