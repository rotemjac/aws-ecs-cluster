variable "region_name" {
  description = ""
  default = "ap-south-1"
}


variable "azs" {
  description = "A list of Availability zones in the region"
  default     = ["ap-south-1a", "ap-south-1b"]
  type = "list"
}