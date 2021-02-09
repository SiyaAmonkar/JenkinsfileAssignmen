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
   module "aws_tomcat" {
  source = "./aws_tomcat"
  

variable "acc" {
  type = string
  default = "access-key"
  
}
variable "sec" {
  type = string
  default = "secret-key"
 
}
