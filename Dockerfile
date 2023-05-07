FROM tomcat:8.5.84

WORKDIR /app

COPY . /app

RUN apt update && \
    apt install -y git openjdk-19-jdk vim
RUN ./build.sh
RUN rm /usr/local/tomcat/conf/logging.properties
RUN rm -Rf /app/*

ENTRYPOINT [ "/usr/local/tomcat/bin/catalina.sh", "run" ]
