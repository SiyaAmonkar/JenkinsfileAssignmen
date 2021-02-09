
provider "aws" {
  region="ap-south-1"
  access_key = var.access
  secret_key = var.secret
}
resource "aws_instance" "Tomcat-Server" {
    ami = "ami-08e0ca9924195beba"
    instance_type = "t2.micro"
    tags = {
        Name = "Tomcat-Server"
    }
    user_data = <<-EOF
  #!/bin/bash
  sudo amazon-linux-extras install tomcat8.5 
  sudo systemctl enable tomcat
  sudo systemctl start tomcat
  EOF
  }
    

variable "access" {
  type = string
}
variable "secret" {
  type = string
}
