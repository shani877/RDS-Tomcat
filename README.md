# RDS-Tomcat Setup Guide

## Prerequisites

### 1. Launch EC2 Instance
- **AMI**: Amazon Linux  
- **Security Groups - Open Ports**:
  - SSH (Port 22)
  - Tomcat (Custom TCP Port 8080)
  - MySQL/Aurora (Port 3306)

---

### 2. Install Terraform
```bash
yum install -y yum-utils shadow-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum -y install terraform
```

---

### 3. Install Git
```bash
yum install git -y
```

---

### 4. Install Java 11
```bash
yum install -y java-11-amazon-corretto.x86_64
```

---

### 5. Install Tomcat 9
```bash
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.tar.gz
tar -xvf apache-tomcat-9.0.98.tar.gz -C /opt/
cd /opt/apache-tomcat-9.0.98/bin/
./startup.sh
curl localhost:8080
```

---

### 6. Clone the Repository and Deploy WAR
```bash
cd
git clone <repo-link>
cd RDS-Tomcat/
mv student.war /opt/apache-tomcat-9.0.98/webapps/
mv mysql-connector.jar /opt/apache-tomcat-9.0.98/bin/
```

---

### 7. Terraform Setup
```bash
terraform init
terraform plan
terraform apply --auto-approve
```

---

### 8. Configure Tomcat for MySQL Database

Edit the `context.xml` file:
```bash
cd /opt/apache-tomcat-9.0.98/conf/
vi context.xml
```

Add the following resource inside `<Context>`:
```xml
<Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource"
          maxTotal="100" maxIdle="30" maxWaitMillis="10000"
          username="admin" password="123456" driverClassName="com.mysql.jdbc.Driver"
          url="jdbc:mysql://<RDS-ENDPOINT>:3306/student"/>
```

**Note**: Replace `<RDS-ENDPOINT>`, `username`, and `password` accordingly.

---

### 9. MySQL Setup
```bash
yum install mysql -y
mysql -h <RDS-ENDPOINT> -u admin -p
```

Once logged in:
```sql
SHOW DATABASES;
USE student;
-- Paste schema from Tomcat-rds file here
EXIT;
```

---

### 10. Restart Tomcat
```bash
cd /opt/apache-tomcat-9.0.98/bin/
./shutdown.sh
./startup.sh
```
