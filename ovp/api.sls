include:
  - .install.gettext
  - .install.git
  - .install.python3
  - ..common.install.pm2
  - ..common.install.nginx
  # - .scripts.certify
  - ..common.install.certbot
  - .install.java8
  - .install.es2
  - .install.structure
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
