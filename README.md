# pull_hub2push_nexus
Pull docker images  from Docker hub and push to Local Nexus repository

### Use case:
Sometimes you don't internet access in docker and kubernetes machines that's way we have to create new  local docker registry  example(Nexus) and without this script you have to integrate you local machine with nexus, pull docker images from dockerhub, login nexus, change image name and push to nexus it takes your time much.

### Requirements: <br />
* Firstly change variables on script (nexus url, user and pass) <br />
* Docker must be installed on your local machine <br />
* Internet access on your local machine <br />

### For execute:
```
git clone  https://github.com/BabakMammadov/push_nexus.git
cd push_nexus
chmod +x  push_nexus.sh
cp push_nexus.sh /usr/local/bin

Example
push_nexus.sh  centos  debian  ubuntu
--- Image centos is already exist on your local machine ....
--- Pushing image centos to Nexus....
--- Image name: nexus.kblab.local:8083/v1/repositories/dockerlab/centos ....
--- Image doesn't exist on your local machine ,  Pulling image debian ....
--- Pushing image debian to Nexus....
--- Image name: nexus.kblab.local:8083/v1/repositories/dockerlab/debian ....
--- Image ubuntu is already exist on your local machine ....
--- Pushing image ubuntu to Nexus....
--- Image name: nexus.kblab.local:8083/v1/repositories/dockerlab/ubuntu ....
```

That's all.
