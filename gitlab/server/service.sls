{%- from "gitlab/map.jinja" import gitlab with context %}

gitlab_server_reconfigure:
  cmd.wait:
    - name: gitlab-ctl reconfigure

gitlab_server_restart:
  cmd.wait:
    - name: gitlab-ctl restart

gitlab_server_start:
  cmd.wait:
    - name: gitlab-ctl start

gitlab_server_stop:
  cmd.wait:
    - name: gitlab-ctl stop

gitlab_server_nginx_restart:
  cmd.wait:
    - name: gitlab-ctl restart nginx