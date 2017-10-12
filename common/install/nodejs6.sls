node:
  pkgrepo.managed:
    - humanname: NodeJS 6.x
    - name: deb https://deb.nodesource.com/node_6.x xenial main
    - dist: xenial
    - file: /etc/apt/sources.list.d/nodejs-6x.list
    - keyid: 9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: install_node

yarn:
  pkgrepo.managed:
    - humanname: Yarn
    - name: deb https://dl.yarnpkg.com/debian/ stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/yarn.list
    - keyid: 72ECF46A56B4AD39C907BBB71646B01B86E50310
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: install_node

install_node:
  pkg.installed:
    - pkgs:
      - nodejs
      - yarn
