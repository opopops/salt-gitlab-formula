{%- from "gitlab/map.jinja" import gitlab with context %}

{%- set osfamily   = salt['grains.get']('os_family') %}
{%- set os         = salt['grains.get']('os') %}
{%- set osrelease  = salt['grains.get']('osrelease') %}
{%- set oscodename = salt['grains.get']('oscodename') %}

{%- if gitlab.manage_repo %}
  {%- if osfamily == 'Debian' %}
gitlab_gnupg_pkg:
  pkg.installed:
    - name: gnupg
    - require_in:
      - pkgrepo: gitlab_repo
  {%- endif %}
  
  {%- if 'repo' in gitlab and gitlab.repo is mapping %}
gitlab_repo:
  pkgrepo.managed:
    {%- for k, v in gitlab.repo.items() %}
    - {{k}}: {{v}}
    {%- endfor %}
    - retry:
        attempts: 5
        interval: 10
  {%- endif %}
{%- endif %}
