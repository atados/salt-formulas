include:
  - .install.git
  - .install.python3
  - ..common.install.pm2
  - .install.nginx
  - .install.java8
  - .install.es2
  - .install.structure

install_api_repo:
  git.latest:
    - name: https://github.com/atados/atados-ovp.git
    - force_checkout: True
    - force_clone: True
    - target: /home/ubuntu/api/repository
    - branch: master
    - user: ubuntu 
    - submodules: True
