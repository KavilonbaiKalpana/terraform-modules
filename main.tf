provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block         = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  availability_zone  = "ap-south-1a"
}

module "ec2" {
  source = "./modules/ec2-instances"

  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
  instance_type = "t3.micro"
}

module "s3" {
  source = "./modules/s3-bucket"

  bucket_name = "replace-with-your-unique-s3-bucket-name-2026"
}

output "instance_id" {
  value = module.ec2.instance_id
}

output "public_ip" {
  value = module.ec2.public_ip
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
