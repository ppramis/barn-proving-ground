# Variables TF File
variable "region" {
  description = "AWS Region "
  default     = "us-east-1"
}

variable "keyname" {
  description = "SSH key pair"
  default = "Peter-useast1-kp"
}

variable "ami_id" {
  description = "AMI ID to be used for BARN "
  default     = "ami-0ffe2443a383cf429"
}

variable "instancetype" {
  description = "Instance Type used for BARN Instance "
  default     = "t2.micro"
}

variable "subnetid" {
  description = "Subnet ID to be used for Instance "
  default     = "subnet-f9b12f9c"
}

variable "AppName" {
  description = "BARN Webserver"
  default     = "BARN Proving Ground webserver"
}

variable "Env" {
  description = "BARN Proving Ground"
  default     = "Dev"
}

variable "ClientIp" {
  description = "Host IP to be allowed SSH for"
  default     = "72.83.230.250/32"
}
