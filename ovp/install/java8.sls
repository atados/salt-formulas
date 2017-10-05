accept_oracle_terms:
  debconf.set:
    - name: oracle-java8-installer
    - data:
        'shared/accepted-oracle-license-v1-1': {'type': 'boolean', 'value': True }

java8_repo:
  pkgrepo.managed:
    - humanname: Oracle Java 8
    - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu/ xenial main
    - dist: xenial
    - file: /etc/apt/sources.list.d/java-8.list
    - keyid: 7B2C3B0889BF5709A105D03AC2518248EEA14886
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: java8_pkg

java8_pkg:
  pkg.installed:
    - name: oracle-java8-installer
    - pkgrepo: webupd8-repo
    - requires:
      - debconf: accept_oracle_terms
