install_nginx:
  pkg.installed:
    - pkgs:
      - nginx

/etc/nginx/nginx.conf:
  file.managed:
    - user: root
    - group: root
    - source: salt://common/files/nginx/nginx.conf
