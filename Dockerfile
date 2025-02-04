FROM ubuntu
WORKDIR /opt
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.tar.gz .
RUN tar -xvzf apache-tomcat-9.0.98.tar.gz
RUN apt update && apt install openjdk-11-jdk -y && apt install vim -y
CMD ["/opt/apache-tomcat-9.0.98/bin/catalina.sh","run"]
COPY ./student.war ./apache-tomcat-9.0.98/webapps/
COPY ./mysql-connector.jar ./apache-tomcat-9.0.98/lib
