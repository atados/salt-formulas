#bin/bash 

ENVNAME=`cat /env`

if [ -f ~/client/deploy/.lock ];
then
    echo "Seems like there is already a deploy in progress."
    exit 1;
fi

# Lock deploys
touch ~/client/deploy/.lock

# Create deploy structure
PRJ=`date +%s.%N`
export PRJ
echo ":: Creating deploy structure at run.$PRJ"
cd ~/client/run
mkdir run.$PRJ
cd run.$PRJ
mkdir env
mkdir code

# Install environment
#echo ":: Installing environment"
virtualenv --python=/usr/bin/python3 env > /dev/null
cd env/bin
echo "source ~/client/run/env.sh" >> activate

# Activate env
#echo ":: Activating environment"
source activate

# Checkout repo
#echo ":: Checking out code"
cd ~/client/repository
git fetch --quiet > /dev/null
git reset --hard origin/master --quiet > /dev/null
COMMIT=`git rev-parse --short HEAD`
BRANCH=`git branch | grep "\*" | awk '{print $2}'`
GIT_WORK_TREE=~/client/run/run.$PRJ/code git checkout -f master --quiet > /dev/null

# Install dependencies
echo ":: Installing dependencies"
cd ~/client/run/
LAST=`find ./ -maxdepth 1 -name "run.*" -printf "%f\n" | sort | sed "$ d" | tail -n1`
cd ~/client/run/run.$PRJ/code 
cp -r ../../$LAST/code/node_modules .

yarn install --production=false > /dev/null

# Building
echo ":: Building"
yarn build-release > /dev/null


# mkdir -p build/src/cms/pages
# cp -r ../../$LAST/code/build/src/cms/pages/* build/src/cms/pages/

# Run client
cd build
echo ":: Starting new server"
printf '#!/bin/bash\n' > unix-server.sh
printf "PORT=/tmp/client.run.$PRJ.socket node ./server.js" >> unix-server.sh
pm2 start ./unix-server.sh --name client-$PRJ -- --prj=$PRJ > /dev/null

# Wait until server is up

# while [ `curl --unix-socket /tmp/client.run.$PRJ.socket http:/api/status -s -o /dev/null -w "%{http_code}"` != "200" ]
# do
#   sleep 1
# done


# Copy nginx config
#echo ":: Swap nginx config"
rm ~/client/nginx.conf.d/partials/location/beta.parceirosvoluntarios.atados.com.br.* 
rm ~/client/nginx.conf.d/partials/upstream/beta.parceirosvoluntarios.atados.com.br.* 

cp ~/client/deploy/nginx/location.conf ~/client/nginx.conf.d/partials/location/beta.parceirosvoluntarios.atados.com.br.$PRJ.conf
cp ~/client/deploy/nginx/upstream.conf ~/client/nginx.conf.d/partials/upstream/beta.parceirosvoluntarios.atados.com.br.$PRJ.conf

perl -pi -e 's/{PRJ}/$ENV{PRJ}/g' ~/client/nginx.conf.d/partials/location/beta.parceirosvoluntarios.atados.com.br.$PRJ.conf
perl -pi -e 's/{PRJ}/$ENV{PRJ}/g' ~/client/nginx.conf.d/partials/upstream/beta.parceirosvoluntarios.atados.com.br.$PRJ.conf

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
pm2 list | grep client | awk '{print $2}' | grep -v $PRJ | xargs pm2 delete > /dev/null

# Remove old deploys
#echo ":: Removing old deploys."
cd ~/client/run
find ./ -maxdepth 1 -name "run.*" -printf "%f\n" | sort | sed "$ d" | xargs rm -r >/dev/null 2>&1 # This list folders, sort, remove last line from list and rm the rest

# Remove old sockets
cd /tmp
find ./ -maxdepth 1 -name "client.run.*" -printf "%f\n" | sort | sed "$ d" | xargs rm -f >/dev/null 2>&1

# Dump log
cd ~/client/run
echo $PRJ >> log

# Unlock
rm ~/client/deploy/.lock

echo ":: Running $BRANCH/$COMMIT on $ENVNAME"

