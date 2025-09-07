provider "aws" {
    region = "us-west-2"

    access_key = "anaccesskey"
    secret_key = "asecretkey"
    s3_use_path_style = true
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_requesting_account_id = true

    endpoints {
        ec2 = "https://localhost:5466"
    }
}

data "aws_ami" "linux" {
    most_recent = true

    filter {
        name = "name"
        values = ["amzn2-ami-hvm-2.0.*-x86_64-ebs"]
    }

    owners = ["137112412989"] # amazon
}

resource "aws_instance" "app_server" {
    ami = data.aws_ami.linux.id
    instance_type = "t2.micro"

    tags = {
        Name = "hashicorp-learn"
    }
}
