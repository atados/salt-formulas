include:
  - ..common.install.git
  - ..common.install.python3
  - ..common.install.pm2
  - ..common.install.nginx
  - ..common.install.certbot
  - .install.structure
  - .install.babel-node

install_api_repo:
  git.latest:
    - name: https://github.com/atados/new-client.git
    - force_checkout: True
    - force_reset: True
    - force_clone: True
    - target: /home/ubuntu/client/repository
    - branch: master
    - user: ubuntu 
    - submodules: True

