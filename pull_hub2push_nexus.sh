#!/bin/bash

NEXUS_URL="nexus.example.local:8083/v1/repositories"
DOCKER_REPO="dockerlab"
NEXUS_USER='user'
NEXUS_PASS='pass'

# For integrate you docker with nexus you have to add insecure registry to your docker config
FILE=/etc/docker/daemon.json
if [ ! -f "$FILE" ]; then
    echo "$FILE does not exist, make nexus on docker config and restart docker"
    echo '{ "insecure-registries":["nexus.example.local:8083"] }' > $FILE
    sudo systemctl daemon-reload
    echo "--- Docker service restating ...."
    sudo systemctl restart docker
    sudo systemctl is-active --quiet docker  && echo "--- Docker Service is running ...."
fi


# Check arguments
if [ "$#" -eq '0' ]; then
    echo "You have to set any image name for pull from docker hub  and push to nexus ...."
    exit 1
fi

for var in "$@"
do
    image_tag_push() {
        sudo docker tag $var  $NEXUS_URL/$DOCKER_REPO/$var >> /dev/null
        sudo docker login -u $NEXUS_USER -p $NEXUS_PASS $NEXUS_URL/$DOCKER_REPO > /dev/null 2>&1
        echo "--- Pushing image $var to Nexus...."
        sudo docker push $NEXUS_URL/$DOCKER_REPO/$var >> /dev/null
        echo "--- Image name: $NEXUS_URL/$DOCKER_REPO/$var .... "
    }

    # Check docker images exist on your local
    result=$(sudo docker images -q $var)
    if [[ "$result" != '' ]]; then
        echo "--- Image $var is already exist on your local machine ...."
        image_tag_push
    else
        echo "--- Image doesn't exist on your local machine ,  Pulling image $var ...."
        sudo docker pull  $var >> /dev/null
        image_tag_push
    fi
done
