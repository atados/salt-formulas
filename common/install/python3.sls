python_repo:
  pkgrepo.managed:
    - humanname: Jonathon Fernyhough's Python 3.6
    - name: deb http://ppa.launchpad.net/jonathonf/python-3.6/ubuntu/ xenial main
    - dist: xenial
    - file: /etc/apt/sources.list.d/jonathonf-python-3.6.list
    - keyid: 4AB0F789CBA31744CC7DA76A8CF63AD3F06FC659
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: install_python

install_python:
  pkg.installed:
    - pkgs:
      - python3.6
      - python-pip
      - python3-pip
      - python3-dev

virtualenv:
  pip.installed:
    - bin_env: '/usr/bin/pip3'
    - require:
      - pkg: install_python
