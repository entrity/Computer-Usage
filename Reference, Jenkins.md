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
