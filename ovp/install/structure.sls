/home/ubuntu/api:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/deploy:
  file.recurse:
    - user: ubuntu
    - group: ubuntu
    - source: salt://ovp/files/deploy

/home/ubuntu/api/logs:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/logs/nginx:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/logs/nginx/http:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/logs/nginx/https:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/nginx.conf.d:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/nginx.conf.d/partials:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/nginx.conf.d/partials/upstream:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/nginx.conf.d/partials/location:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/nginx.conf.d/partials/log:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/nginx.conf.d/server.conf:
  file.managed:
    - user: ubuntu
    - group: ubuntu
    - source: salt://ovp/files/nginx/server.conf

/home/ubuntu/api/nginx.conf.d/secure.conf:
  file.managed:
    - user: ubuntu
    - group: ubuntu
    - source: salt://ovp/files/nginx/secure.conf

/home/ubuntu/api/nginx.conf.d/unsecure.conf:
  file.managed:
    - user: ubuntu
    - group: ubuntu
    - source: salt://ovp/files/nginx/unsecure.conf

/home/ubuntu/api/repository:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/api/run:
  file.directory:
    - user: ubuntu
    - group: ubuntu

# Project settings 
/home/ubuntu/api/run/env.sh:
  file.managed:
    - user: ubuntu
    - group: ubuntu

/env:
  file.managed:
    - user: ubuntu
    - group: ubuntu
