# Jenkins

## Set up

Follow the tutorial at https://jenkins.io/doc/tutorials/build-a-java-app-with-maven/ for help

Set up three Docker images:

1. Jenkins
2. Blue Ocean (a Jenkins plugin)
3. One for your private image registry

(Jenkins will start a container to run the pipeline on its own docker server)

## Private registry

```bash
# Tag the image with the registry domain.
docker tag insureio reg.qa/insureio:2.wjre
# Push it to the private registry.
docker push reg.qa/insureio:2.wjre
# Add ca certs for registry to jenkins (unsure which files are needed)
for CONTAINER in jenkins-docker jenkins-blueocean; do
  docker cp reg.qa.crt $CONTAINER:/usr/local/share/ca-certificates/domain.crt
  docker cp myCA.pem $CONTAINER:/usr/local/share/ca-certificates
  docker exec -u 0 $CONTAINER update-ca-certificates
done
# May need to restart the docker service first? second?
```

In your Jenkinsfile, set `pipeline.agent.docker.image` to `'reg.qa/insureio:2.wjre'` and `pipeline.agent.docker.registryUrl` to `'https://reg.qa/'`.

### Testing private registry

Make sure the repo responds:

```bash
# Get the name of the running registry container
docker ps | grep registry # See last column
# Get the ip of the running registry container
docker inspect $REGISTRY | grep IPAddress
# Try curl
curl -k https://$IPADDR/v2/_catalog
# Try curl from jenkins container
docker exec -t jenkins-docker /sbin/apk add curl
docker exec -t jenkins-docker curl https://reg.qa/v2/_catalog
```

### Mounting

Use the `-v` arg in `pipeline.agent.docker.args`.

The source refers to a location in the Jenkins container, not to a volume nor to a location on the host.

```
    agent {
        docker {
            image 'reg.qa/insureio:2.wjre'
            /* The mount arg here mounts from Jenkins. (Doesn't work to mount an actual volume or host dir.) */
            args '-v /var/insureio:/var/insureio -u root --privileged'
            registryUrl 'https://reg.qa/'
        }
    }
```

## Pipeline

- Make sure you're _NOT_ using the "Lightweight checkout," which has a bug that makes it not evaluate variables in the "Branches to build" section.
		
## Troubleshooting

```bash
# Enter a shell for jenkins-docker
docker exec -it jenkins-docker sh
# 
```

### Running a local registry of Docker images, you might have SSL certificate refused.

1. Verify the cert with `openssl verify -cacert myCA.pem myDomain.crt`
1. Put the cert onto `jenkins-docker` (see below). If `curl` succeeds there but `docker pull` in the pipeline still fails, you probably need to add the cert to `/etc/docker/certs` in the host and then restart the docker service (also on the host).

```bash
# Add CA cert to Jenkins container
docker cp reg.qa.crt jenkins-docker:/usr/local/share/ca-certificates/domain.crt
docker cp myCA.pem jenkins-docker:/usr/local/share/ca-certificates
docker exec -u 0 jenkins-docker update-ca-certificates
# Test CA cert (needs to be on both Jenkins and on Registry)
docker exec jenkins-docker apk add curl
docker exec jenkins-docker curl https://reg.qa/v2/_catalog
```

### Jenkins workspace does not exist

It might be as simple as adding `sh 'mkdir -p "${WORKSPACE}"'` at the top of the pipeline. But it might require setting up certificates for the local image registry again.


## Docker image update
Do you want to add a dependency to an image that's getting used by Jenkins.

**On the host**
```bash
# Start up an instance
docker run -it reg.qa/insureio:mariadb-5.5 /bin/bash
```

**In the container**
```bash
# Do some task to chagne the system, e.g.:
yum makecache
yum install -y qpdf
```

**On the host**
```bash
# Get the id or name of the open continer
docker ps
# Commit the changed container
docker commit kind_volhard reg.qa/insureio:mariadb-5.5
# Push the changes to the private registry
docker push reg.qa/insureio:mariadb-5.5
```

**On the jenkins container**
```bash
# Pull the updated image
docker pull reg.qa/insureio:mariadb-5.5
```
