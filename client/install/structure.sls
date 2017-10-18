/home/ubuntu/client:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/deploy:
  file.recurse:
    - user: ubuntu
    - group: ubuntu
    - source: salt://client/files/deploy

/home/ubuntu/client/certbot:
  file.recurse:
    - user: ubuntu
    - group: ubuntu
    - source: salt://client/files/certbot

/home/ubuntu/client/repository:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/run:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/logs:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/logs/nginx:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/logs/nginx/http:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/logs/nginx/https:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/nginx.conf.d:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/nginx.conf.d/partials:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/nginx.conf.d/partials/upstream:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/nginx.conf.d/partials/location:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/nginx.conf.d/partials/log:
  file.directory:
    - user: ubuntu
    - group: ubuntu

/home/ubuntu/client/nginx.conf.d/server.conf:
  file.managed:
    - user: ubuntu
    - group: ubuntu
    - source: salt://client/files/nginx/server.conf

/home/ubuntu/client/nginx.conf.d/secure.conf:
  file.managed:
    - user: ubuntu
    - group: ubuntu
    - source: salt://client/files/nginx/secure.conf

/home/ubuntu/client/nginx.conf.d/unsecure.conf:
  file.managed:
    - user: ubuntu
    - group: ubuntu
    - source: salt://client/files/nginx/unsecure.conf

# Project settings 
/home/ubuntu/client/run/env.sh:
  file.managed:
    - user: ubuntu
    - group: ubuntu

/env:
  file.managed:
    - user: ubuntu
    - group: ubuntu
    - contents:
      - production
