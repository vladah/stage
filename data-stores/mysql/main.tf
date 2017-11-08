provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "$(var.db_password)"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my_state_bucket"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}


terraform {
  backend "s3" {
    bucket = "my_state_bucket"
    key = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
  }
}

