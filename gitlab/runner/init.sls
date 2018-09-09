{%- from "gitlab/map.jinja" import gitlab with context %}

include:
  - gitlab.repo
  - gitlab.runner.install
  - gitlab.runner.config
  - gitlab.runner.service
