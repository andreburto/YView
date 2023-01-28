#!/bin/bash

EC2_USER=ec2-user
TOMCAT_VERSION=8.5.84
TOMCAT_PATH=/home/$EC2_USER/bin/apache-tomcat-${TOMCAT_VERSION}
TOMCAT_ZIP=apache-tomcat-${TOMCAT_VERSION}.zip

yum install -y java-11-amazon-corretto git

amazon-linux-extras install -y nginx1

systemctl stop nginx

cat > /etc/nginx/nginx.conf << EOL
events {}
http {
    server {
        listen 0.0.0.0:80;

        location / {
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_pass http://localhost:8080/YViewApp/;
        }
    }
}
EOL

curl -O https://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/${TOMCAT_ZIP}

unzip $TOMCAT_ZIP -d /home/$EC2_USER/bin

chown -R $EC2_USER:$EC2_USER $TOMCAT_PATH
chmod a+x $TOMCAT_PATH/bin/*.sh

git clone https://github.com/andreburto/YView.git /home/$EC2_USER/YView

chown -R $EC2_USER:$EC2_USER /home/$EC2_USER/YView

cd /home/$EC2_USER/YView

sudo -u $EC2_USER ./build.sh

sudo -u $EC2_USER $TOMCAT_PATH/bin/startup.sh

systemctl start nginx
