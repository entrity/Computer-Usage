# Troubleshooting Protractor on Jenkins

If you have a failing Protractor spec on Jenkins:

1. On the qa server, `ProxyPass` some request to your `jenkins-docker` container
1. Enter your Jenkins container
2. Spin up a container of your test image, exposing the port for your app server

## ProxyPass

Get the IP address of `jenkins-docker` with `docker inspect jenkins-docker | grep IPAddr`

```
# /etc/httpd/sites-enabled/docker.conf
<VirtualHost *:80>
        ServerName app.docker.qa
        ServerAlias pinney.docker.qa
        ServerAlias nmb.docker.qa
        # Use the IP address of jenkins-docker and whatever HOSTPORT you want
        ProxyPass "/" "http://172.18.0.4:3000/"
</VirtualHost>
```

## Enter Jenkins container

```bash
docker exec -it jenkins-docker sh
```

## Start up test container

The `-p` option lets you forward a container port to the host (`jenkins-docker`).

```bash
#!/bin/bash

TAG=${1:-latest}

set /usr/local/rvm/bin/rvm-shell

if ! docker ps | grep insureio:$TAG | grep Up; then
  echo "Starting new container for $TAG"
  docker run -it -p 3000:3000 \
    -v /var/jenkins_home/workspace/first-insureio:/Insureio \
    -v /var/insureio:/var/insureio \
    -u root --privileged reg.qa/insureio:$TAG "${@}"
else
  echo docker exec -it $(docker ps | grep insureio:$TAG | tail -n1 | awk '{print $1}') "${@}"
fi
```

## Start up servers within test container

```bash
grep -q compulife.one /etc/hosts || base64 -d <<< NjYuMjI4LjUxLjI1MSBjb21wdWxpZmUub25lCg== >> /etc/hosts
cd Insureio
sed -i 's@args: \[ @args: ["--disable-dev-shm-usage", "--no-sandbox", @' config/protractor.js
/usr/libexec/mysqld --user=root &
bundle exec rake db:clean db:seed db:seed:protractor
bundle exec rails server -e development -b 0.0.0.0
```

## Run protractor tests from dev environment

1. Change your `config/protractor.js` file so that `baseUrl: 'http://pinney.docker.qa:3000'`.
2. Run protractor tests `npm run protractor`
