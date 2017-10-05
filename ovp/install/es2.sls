include:
  - .java8

elasticsearch_repo:
  pkgrepo.managed:
    - humanname: Elasticsearch 2.x
    - name: deb http://packages.elastic.co/elasticsearch/2.x/debian stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - keyid: D88E42B4
    - keyserver: keyserver.ubuntu.com

elasticsearch_pkg:
  pkg.installed:
  - name: elasticsearch
  - version: 2.4.5
  - require:
    - pkgrepo: elasticsearch_repo
    - pkg: java8_pkg
