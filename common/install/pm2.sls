include:
  - .nodejs6

install_pm2:
  npm.installed:
    - name: pm2
    - require:
      - pkg: install_node
