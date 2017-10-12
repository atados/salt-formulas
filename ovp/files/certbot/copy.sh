 #!/bin/bash
  
sudo cp -L -r /etc/letsencrypt/live/ /home/ubuntu/api/certbot/certs/
sudo chown ubuntu:ubuntu -R /home/ubuntu/api/certbot/certs/
