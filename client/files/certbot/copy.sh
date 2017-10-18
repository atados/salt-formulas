 #!/bin/bash
  
sudo cp -L -r /etc/letsencrypt/live/ /home/ubuntu/client/certbot/certs/
sudo chown ubuntu:ubuntu -R /home/ubuntu/client/certbot/certs/
