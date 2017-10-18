include:
  - ...common.install.nodejs6

install_babel_node:
  npm.installed:
    - name: babel-cli
    - require:
      - pkg: install_node
