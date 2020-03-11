# Jenkins

## Set up

Follow the tutorial at
https://jenkins.io/doc/tutorials/build-a-java-app-with-maven/
for help

### Overview

Set up three Docker images:

1. Jenkins
2. Blue Ocean (a Jenkins plugin)
3. One for running your app

The first two images should be running as servers all the time.

### Running your app

This image should have a volume mounted from your machine, which contains the git repository and any artifacts that you don't want to re-download or re-build every time your Jenkins pipeline is triggered.



New item
	Pipeline
		General
			Github Project (check)
		Build Triggers
			Trigger builds remotely (check and provide a token)
				M2UzNWVjZmQ3N2JlOWJhMTk4NjE1ZDEx
				Use the following URL to trigger build remotely: JENKINS_URL/job/tutorial/build?token=TOKEN_NAME or /buildWithParameters?token=TOKEN_NAME
				Optionally append &cause=Cause+Text to provide text that will be included in the recorded build cause.
				
## In Jenkinsfile

### Private registry

```bash
# Tag the image with the registry domain.
docker tag insureio reg.qa/insureio:2.wjre
# Push it to the private registry.
docker push reg.qa/insureio:2.wjre
```

Use `pipeline.agent.docker.image 'reg.qa/insureio:2.wjre` and `pipeline.agent.docker.registryUrl 'https://reg.qa/`.

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
		
## Troubleshooting

Running a local registry of Docker images, you might have SSL certificate refused.

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
