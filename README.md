git clone 

```
cd jenkins-agent-service-ubuntu
nano create-agent-jenkins.sh
```

# setting variable

```
# Set variables for clarity and maintainability
JENKINS_URL="http://192.168.0.9:8088"
JENKINS_SECRET="d3f8c50541de914341bab672a78df3b2f80ee111005775c261f92c4ebc3d60ac"
JENKINS_NAME="node_satu"
JENKINS_WORKDIR="/var/jenkins"
JENKINS_AGENT_JAR_URL="$JENKINS_URL/jnlpJars/agent.jar"
USER_SERVICE="root"
```

sh ./create-agent-jenkins.sh


# Jenkins

```
docker run -u root --name jenkins-dev -d -v /datajenkins:/var/jenkins_home -p 8877:8080 -p 50000:50000 jenkins/jenkins:latest
```

enjoy
