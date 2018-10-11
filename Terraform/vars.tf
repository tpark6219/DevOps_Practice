variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AVAILABILITY_ZONES" {
default {
  "1" = "us-east-1a"
  "2" = "us-east-1b"
  "3" = "us-east-1c"
  }

}
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-04681a1dbd79675a5"
  }
}
