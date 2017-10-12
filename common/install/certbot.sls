certbot_repo:
  pkgrepo.managed:
    - humanname: NodeJS 6.x
    - name: deb http://ppa.launchpad.net/certbot/certbot/ubuntu xenial main
    - dist: xenial
    - file: /etc/apt/sources.list.d/certbot.list
    - keyid: 7BF576066ADA65728FC7E70A8C47BE8E75BCA694
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: install_certbot

install_certbot:
  pkg.installed:
    - pkgs:
      - python-certbot-nginx 

