{%- from "gitlab/map.jinja" import gitlab with context %}

include:
  - gitlab.server.install
  - gitlab.server.service

{%- if salt['pillar.get']('gitlab:server:secrets', False) %}
gitalb_server_secrets:
  file.serialize:
    - name: {{ gitlab.server_secrets }}
    - dataset_pillar: gitlab:server:secrets
    - formatter: json
    - makedirs: True
    - user: root
    - group: root
    - mode: 600
    - merge_if_exists: True
    - watch_in:
      - cmd: gitlab_server_reconfigure
{%- endif %}

gitlab_server_config:
  file.managed:
    - name: {{ gitlab.server_config }}
    - source: salt://gitlab/files/server/gitlab.rb.jinja
    - template: jinja
    - makedirs: True
    - user: root
    - group: root
    - mode: 600
    - watch_in:
      - cmd: gitlab_server_reconfigure