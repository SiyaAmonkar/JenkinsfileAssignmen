/*module "tomcat_container" {
  source = "./musicstore"
  password=var.pass
}*/

/* module "testing_containers" {
  source = "./SeleniumTest"
}*/
 /* variable "pass" {
  type = string
}*/
   module "deploy_aws" {
  source = "./aws_tomcat"
  access=var.acc
  secret=var.sec
     }
  

variable "acc" {
  type = string
  default = "access-key"
  
}
variable "sec" {
  type = string
  default = "secret-key"
 
}
