provider "aws" {
  region = "us-west-2"  # Change the region as needed
}

# Create a security group for the RDS instance
resource "aws_security_group" "mariadb_sg" {
  name        = "mariadb-sg"
  description = "Security group for MariaDB RDS"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all IPs, you can restrict as needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create the RDS MariaDB instance
resource "aws_db_instance" "mariadb" {
  identifier        = "mariadb-instance"
  engine            = "mariadb"
  engine_version    = "10.5"  # You can adjust the version as needed
  instance_class    = "db.t3.micro"  # Adjust instance type as needed
  allocated_storage = 20  # Storage in GB
  db_name           = "mydatabase"
  username          = "admin"
  password          = "your_password_here"  # Make sure to use a secure password
  multi_az          = false
  storage_type      = "gp2"
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.mariadb_sg.id]

  # Optional parameters
  skip_final_snapshot = true
  backup_retention_period = 7  # Retention period for backups (in days)
  tags = {
    Name = "MariaDB-RDS-Instance"
  }
}

# Outputs
output "db_endpoint" {
  value = aws_db_instance.mariadb.endpoint
}

output "db_name" {
  value = aws_db_instance.mariadb.db_name
}

output "db_instance_identifier" {
  value = aws_db_instance.mariadb.identifier
}
