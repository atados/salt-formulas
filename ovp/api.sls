include:
  - .install.gettext
  - ..common.install.git
  - ..common.install.python3
  - ..common.install.pm2
  - ..common.install.nginx
  - ..common.install.certbot
  - .install.java8
  - .install.rabbitmq
  - .install.es2
  - .install.structure
  # - .scripts.certify
  # - .scripts.deploy

install_api_repo:
  git.latest:
    - name: https://github.com/atados/atados-ovp.git
    - force_checkout: True
    - force_reset: True
    - force_clone: True
    - target: /home/ubuntu/api/repository
    - branch: master
    - user: ubuntu 
    - submodules: True
