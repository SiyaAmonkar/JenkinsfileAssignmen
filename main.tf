module "tomcat_container" {
  source = "./musicstore"
  password=var.pass
}

 module "testing_containers" {
  source = "./SeleniumTest"
} 
  
variable "pass" {
  type = string
}
