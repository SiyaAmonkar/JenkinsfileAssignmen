
provider "aws" {
  region="ap-south-1"
  access_key = var.acc
  secret_key = var.sec
}
resource "aws_instance" "Tomcat-Server" {
    ami = "ami-08e0ca9924195beba"
    instance_type = "t2.micro"
    tags = {
        Name = "Tomcat-Server"
    }
  }
    

variable "acc" {
  type = string
}
variable "sec" {
  type = string
}
