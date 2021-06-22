# Jenkins

Jenkins runs our automated test pipeline on Docker.

It is integrated with our insureio Github repo. A push to Github triggers the pipeline.

It is integrated with Rocket.chat. It posts success/failure messages to the `#development` channel.

## Command-line access

```bash
ssh qa
# Then in qa:
docker exec -it jenkins-docker sh
# Then in the jenkins container:
/var/insureio/launch.sh
```

The `launch.sh` script is just a helper, with one command: `docker run -v /var/jenkins_home/workspace/first-insureio:/Insureio -v /var/insureio:/var/insureio -u root --privileged -it reg.qa/insureio:2.wjre`

## Triggering pipeline manually

You can trigger the pipeline with a POST to `https://jenkins.insureio.com/generic-webhook-trigger/invoke?token=$TOKEN` with the params `ref`, `before`, `after`, and `pusher.name`:

```bash
ref=`git rev-parse --abbrev-ref HEAD`
after=`git rev-parse --abbrev-ref HEAD`
before=0000000000000000000000000000000000000000 # A dummy is okay to use
TOKEN # The token value chosen in the Jenkins pipeline's config
```

## Setup

### DB image: `rails-db`

The DB runs on an image separate from the rails app image. It was created with:
```bash
docker run --name rails-db -e MYSQL_ROOT_PASSWORD=gravityisgonnabetheendofme -d mariadb:10.3
```

It was subsequently run with the following to create a bind-mount, supplying the host's db files to the container:
```bash
# NB: Requires stopping the db server on the host so that /var/lib/mysql/aria_log_control could be locked by the mysqld process on the container.
# NB: Requires removing /var/lib/mysql/tc.log because its magic number was not correct for the container.
docker run \
  -v /var/lib/mysql:/var/lib/mysql \
  --network jenkins --ip 172.18.0.55 \
  --name rails-db -e MYSQL_ROOT_PASSWORD=gravityisgonnabetheendofme -d mariadb:10.3
```

A container with this image should be running all the time because Jenkins will spin up a container for only the rails app, and the rails app will try to connect to the db container.

### Rails app image: `insureio`

The rails app was created with the Dockerfile found in the insureio codebase. (It has been tweaked since, however.)

This image should be pushed to the local registry `reg.qa` because the Jenkinsfile tells jenkins to look there for the image.

## Config

https://jenkins.insureio.com/job/first-insureio/configure

### Config > General

* [x] Do not allow concurrent builds // this one could be toggled off
* [x] GitHub project
* Project url: `https://github.com/pic-development/insureio/`

### Config > Build Triggers

* [x] Generic Webhook Trigger

### Post content parameters

* Variable `GITAFTER`
* Expression `$.after`
* [x] JSONPath
* Default value `refs/heads/master`

* Variable `GITBEFORE`
* Expression `$.before`
* [x] JSONPath

* Variable `GITPUSHER`
* Expression `$.pusher.name`
* [x] JSONPath

* Variable `GITREF`
* Expression `$.ref`
* [x] JSONPath
* Default value `refs/heads/master`

* Variable `GITREFSUFFIX`
* Expression `$.ref`
* [x] JSONPath
* Value filter `refs/heads`
* Default value `master`

* Token `tokie`
* Cause `$GITPUSHER Github push $GITREF $GITAFTER`
* [x] Print contributed variables

### Config > Option filter

### Config > Advanced Project Options

### Config > Pipeline

* Definition `Pipeline script from SCM`
* SCM `Git`
* Repository URL `git@github.com:pic-development/Insureio.git`
* Credentials `git (ssh deploy key for Jenkins to hit github for insureio)`
* Branches to build `*/master`
* Repository browser `(Auto)`
* Script Path `Jenkins/Jenkinsfile`
* [ ] Lightweight checkout // Seriously, there's a bug in this, so don't check it.
