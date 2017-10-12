#!/bin/bash

sudo certbot certonly --nginx -d api.beta.atados.com.br --non-interactive --agree-tos --email webmaster@atados.com.br
