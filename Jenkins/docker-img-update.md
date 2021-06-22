# Docker image update

**On the host**
```bash
# Start up an instance
docker run -it reg.qa/insureio:mariadb-5.5 /bin/bash
```

**In the container**
```bash
# Do some task to change the system, e.g.:
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
