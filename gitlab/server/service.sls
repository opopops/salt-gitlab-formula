{%- from "gitlab/map.jinja" import gitlab with context %}

gitlab_server_reconfigure:
  cmd.wait:
    - name: gitlab-ctl reconfigure
    - retry:
        attempts: 3
        until: True
        interval: 5

gitlab_server_restart:
  cmd.wait:
    - name: gitlab-ctl restart
    - retry:
        attempts: 3
        until: True
        interval: 5

gitlab_server_start:
  cmd.wait:
    - name: gitlab-ctl start
    - retry:
        attempts: 3
        until: True
        interval: 5

gitlab_server_stop:
  cmd.wait:
    - name: gitlab-ctl stop
    - retry:
        attempts: 3
        until: True
        interval: 5

gitlab_server_nginx_restart:
  cmd.wait:
    - name: gitlab-ctl restart nginx
    - retry:
        attempts: 3
        until: True
        interval: 5
