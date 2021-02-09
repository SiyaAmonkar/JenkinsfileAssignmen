/*module "tomcat_container" {
  source = "./musicstore"
  password=var.pass
}*/

/* module "testing_containers" {
  source = "./SeleniumTest"
}*/
   module "aws_tomcat {
  source = "./aws_tomcat"
  
variable "pass" {
  type = string
}
variable "acc" {
  type = string
  
}
variable "sec" {
  type = string
 
}
