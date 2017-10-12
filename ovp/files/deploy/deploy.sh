#!/bin/bash 

ENVNAME=`cat /env`

if [ -f ~/api/deploy/.lock ];
then
    echo "Seems like there is already a deploy in progress."
    exit 1;
fi

# Pip
PIP_DOWNLOAD_CACHE=$HOME/.pip_download_cache
export PIP_DOWNLOAD_CACHE

# Lock deploys
touch ~/api/deploy/.lock

# Create deploy structure
PRJ=`date +%s.%N`
export PRJ
echo ":: Creating deploy structure at run.$PRJ"
cd ~/api/run
mkdir run.$PRJ
cd run.$PRJ
mkdir env
mkdir code

# Install environment
#echo ":: Installing environment"
virtualenv --python=/usr/bin/python3.6 env > /dev/null
cd env/bin
echo "source ~/api/run/env.sh" >> activate

# Activate env
#echo ":: Activating environment"
source activate

# Checkout repo
#echo ":: Checking out code"
cd ~/api/repository
git fetch --quiet > /dev/null
git reset --hard origin/master --quiet > /dev/null
git submodule update --quiet > /dev/null
COMMIT=`git rev-parse --short HEAD`
BRANCH=`git branch | grep "\*" | awk '{print $2}'`
GIT_WORK_TREE=~/api/run/run.$PRJ/code git checkout -f master --quiet > /dev/null

# Checkout submodules
cd ~/api/run/run.$PRJ/code
git --git-dir="/home/ubuntu/api/repository/.git" submodule update --init --recursive --quiet > /dev/null

# Install dependencies
echo ":: Installing dependencies"
cd ~/api/run/run.$PRJ/code 
pip3 install --quiet -r requirements.txt > /dev/null
pip3 install gunicorn psycopg2 --quiet > /dev/null

# Migrating
echo ":: Executing migrations"
cd ~/api/run/run.$PRJ/code/api
python manage.py migrate > /dev/null
python manage.py collectstatic --noinput > /dev/null
python manage.py compilemessages > /dev/null

# Run API
echo ":: Starting new server"
cd ~/api/run/run.$PRJ/code/api
pm2 start ./server/server.sh --name api-$PRJ > /dev/null

# Copy nginx config
#echo ":: Swap nginx config"
rm ~/api/nginx.conf.d/partials/location/api.beta.atados.com.br.* 
rm ~/api/nginx.conf.d/partials/upstream/api.beta.atados.com.br.* 
rm ~/api/nginx.conf.d/partials/log/* 

cp ~/api/deploy/nginx/location.conf ~/api/nginx.conf.d/partials/location/api.beta.atados.com.br.$PRJ.conf
cp ~/api/deploy/nginx/upstream.conf ~/api/nginx.conf.d/partials/upstream/api.beta.atados.com.br.$PRJ.conf
cp ~/api/deploy/nginx/unsecure_logs.conf ~/api/nginx.conf.d/partials/log/unsecure_logs.$PRJ.conf
cp ~/api/deploy/nginx/secure_logs.conf ~/api/nginx.conf.d/partials/log/secure_logs.$PRJ.conf

perl -pi -e 's/{PRJ}/$ENV{PRJ}/g' ~/api/nginx.conf.d/partials/location/api.beta.atados.com.br.$PRJ.conf
perl -pi -e 's/{PRJ}/$ENV{PRJ}/g' ~/api/nginx.conf.d/partials/upstream/api.beta.atados.com.br.$PRJ.conf
perl -pi -e 's/{PRJ}/$ENV{PRJ}/g' ~/api/nginx.conf.d/partials/log/unsecure_logs.$PRJ.conf
perl -pi -e 's/{PRJ}/$ENV{PRJ}/g' ~/api/nginx.conf.d/partials/log/secure_logs.$PRJ.conf

# Grab workers pid
workers=`ps -aux | grep "nginx: worker" | sed "$ d" | awk '{print $2}'`

# Reload nginx
echo ":: Dropping old server"
sudo service nginx reload > /dev/null

# Wait for workers to die
for job in $workers
do
    while [ -e /proc/$job ]
    do
        sleep 1
    done
done

# Close old server
#echo ":: Closing old uwsgi server."
pm2 list | grep api | awk '{print $2}' | grep -v $PRJ | xargs pm2 delete > /dev/null

# Remove old deploys
#echo ":: Removing old deploys."
cd ~/api/run
find ./ -maxdepth 1 -name "run.*" -printf "%f\n" | sort | sed "$ d" | xargs rm -r >/dev/null 2>&1 # This list folders, sort, remove last line from list and rm the rest

# Remove old sockets
cd /tmp
find ./ -maxdepth 1 -name "api.run.*" -printf "%f\n" | sort | sed "$ d" | xargs rm -f >/dev/null 2>&1

# Dump log
cd ~/api/run
echo $PRJ >> log

# Unlock
rm ~/api/deploy/.lock

echo ":: Running $BRANCH/$COMMIT on $ENVNAME"
