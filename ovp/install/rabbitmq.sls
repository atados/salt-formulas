rabbitmq_pkg:
  pkg.installed:
  - name: rabbitmq-server

rabbitmq-server:
  service.running:
    - enable: True
    - reload: True
    - requires:
      - pkg: rabbitmq_pkg
