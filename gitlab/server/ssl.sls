{%- from "gitlab/map.jinja" import gitlab with context %}

include:
  - gitlab.server.service

{%- if gitlab.server.certificates is defined %}
gitlab_server_ssl_dir:
  file.directory:
    - name: {{ gitlab.server_ssl_dir }}
    - user: root
    - group: root
    - mode: 750

  {%- for certificate, params in gitlab.server.certificates.items() %}
gitlab_server_key_{{certificate}}:
  file.managed:
    - name: {{ gitlab.server_ssl_dir }}/{{certificate}}.key
    {%- if params.key.source is defined %}
    - source: {{ params.key.source }}
      {%- if params.key.source_hash is defined %}
    - source_hash: {{ params.key.source_hash }}
      {%- else %}
    - skip_verify: True
      {%- endif %}
    {% else %}
    - contents_pillar: gitlab:server:certificates:{{certificate}}:key:contents
    {%- endif %}
    - user: root
    - group: root
    - mode: 600
    - require:
      - file: gitlab_server_ssl_dir
    - watch_in:
      - cmd: gitlab_server_nginx_restart

gitlab_server_crt_{{certificate}}:
  file.managed:
    - name: {{ gitlab.server_ssl_dir }}/{{certificate}}.crt
    {%- if params.crt.source is defined %}
    - source: {{ params.crt.source }}
      {%- if params.crt.source_hash is defined %}
    - source_hash: {{ params.crt.source_hash }}
      {%- else %}
    - skip_verify: True
      {%- endif %}
    {%- else %}
    - contents_pillar: gitlab:server:certificates:{{certificate}}:crt:contents
    {%- endif %}
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: gitlab_server_ssl_dir
    - watch_in:
      - cmd: gitlab_server_nginx_restart
  {%- endfor %}
{%- endif %}
