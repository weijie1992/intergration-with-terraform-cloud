# resource "aws_vpc" "tf_cloud" {
#   cidr_block = var.vpc_cidr

#   tags = {
#     Name = "Terraform cloud"
#   }
# }

# resource "aws_subnet" "tf_cloud" {
#   cidr_block = var.subnet_cidr
#   vpc_id     = aws_vpc.tf_cloud.id

#   tags = {
#     Name = "Terraform cloud"
#   }
# }

moved {
  from = aws_vpc.tf_cloud
  to   = module.networking-tf-course.aws_vpc.this
}
moved {
  from = aws_subnet.tf_cloud
  to   = module.networking-tf-course.aws_subnet.this["subnet_1"]
}

module "networking-tf-course" {
  source  = "app.terraform.io/weijie-test/networking-tf-course/aws"
  version = "0.1.0"
  # insert required variables here
  vpc_config = {
    cidr_block = var.vpc_cidr
    name       = "terraform-cloud"
  }

  subnet_config = {
    subnet_1 = {
      cidr_block = var.subnet_cidr
      az         = "ap-southeast-1a"
    }
  }
}
