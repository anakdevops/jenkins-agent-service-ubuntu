#!/bin/bash

rm -rf /usr/local/jenkins-service/start-agent.sh
rm -rf /etc/systemd/system/jenkins-agent.service

# Set variables for clarity and maintainability
JENKINS_URL="http://192.168.0.9:8088"
JENKINS_SECRET="d3f8c50541de914341bab672a78df3b2f80ee111005775c261f92c4ebc3d60ac"
JENKINS_NAME="node_satu"
JENKINS_WORKDIR="/var/jenkins"
JENKINS_AGENT_JAR_URL="$JENKINS_URL/jnlpJars/agent.jar"
USER_SERVICE="root"

# Create the directory for Jenkins service files
mkdir -p /usr/local/jenkins-service
# Change directory to the created directory
cd /usr/local/jenkins-service

echo "create file start-agent.sh"

cat <<EOF > /usr/local/jenkins-service/start-agent.sh
cd /usr/local/jenkins-service
curl -sO "$JENKINS_URL"/jnlpJars/agent.jar
java -jar agent.jar -url "$JENKINS_URL"/ -secret "$JENKINS_SECRET" -name "$JENKINS_NAME" -workDir "$JENKINS_WORKDIR"
exit 0
EOF

echo "file start-agent.sh created"

# Grant execute permission to the service file
chmod +x start-agent.sh

echo "Jenkins agent started in the background."

# Create a systemd service file for Jenkins agent (use a non-root user for security)
cat <<EOF > /etc/systemd/system/jenkins-agent.service
[Unit]
Description=Jenkins Agent

[Service]
WorkingDirectory=$JENKINS_WORKDIR
User=$USER_SERVICE
ExecStart=/bin/bash /usr/local/jenkins-service/start-agent.sh
Restart=always
RestartSec=20

[Install]
WantedBy=multi-user.target
EOF



# Enable and start the systemd service
systemctl daemon-reload
systemctl enable jenkins-agent.service
systemctl start jenkins-agent.service
systemctl status jenkins-agent.service

echo "Jenkins agent service created and started."
