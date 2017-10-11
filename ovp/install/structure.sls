/home/ubuntu/api:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/deploy:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/logs:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/nginx:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/repository:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/run:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/deploy/deploy.sh:
  file.managed:
    - source: salt://ovp/files/deploy/deploy.sh
    - user: ubuntu
    - group: ubuntu
    - mode: 755

/home/ubuntu/api/run/env.sh:
  file.managed:
    - user: ubuntu
    - group: ubuntu

/env:
  file.managed:
    - user: ubuntu
    - group: ubuntu
