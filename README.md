# RDS-Tomcat
Prerequisites

1. Launch Instance
AMI: Amazon linux
Security ports to open:
--> Custom TCP
--> SSH
--> Custom TCP
--> MYSQL/Aurora

2. Install terraform
yum install -y yum-utils shadow-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum -y install terraform

3. Install Git
yum install git -y

4. Install Java-11
yum install -y java-11-amazon-corretto.x86_64

5. Install Tomcat9
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.tar.gz
ls
tar -xvf apache-tomcat-9.0.98.tar.gz -C /opt/
cd /opt/apache-tomcat-9.0.98/
cd bin/
./startup.sh
curl localhost:8080
cd
git clon <repo link>
ls
cd RDS-Tomcat/
ls
mv student.war /opt/apache-tomcat-9.0.98/webapps/student.war
mv mysql-connector.jar /opt/apache-tomcat-9.0.98/bin/mysql-connector.jar
cd

terraform init
terraform plan
terraform apply --auto-approve

cd /opt/apache-tomcat-9.0.98/
cd conf/
ls
vi context.xml 
# in context.xml file add this  
<Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource"
               maxTotal="100" maxIdle="30" maxWaitMillis="10000"
               username="admin" password="123456" driverClassName="com.mysql.jdbc.Driver"
               url="jdbc:mysql://localhost:3306/student"/>
# change password, username and endpoint.

yum install mysql -y
mysql -h <endpoint> -u admin -pDadda,877
show databases;
use student;
paste schema from Tomcat-rds file
exit

cd /opt
cd apache-tomcat-9.0.98/
cd bin/
./startup.sh 
./shutdown.sh 
