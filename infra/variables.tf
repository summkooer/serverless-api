variable "region"{
    description = "Deployment Region"
    default = "us-east-2"
}

variable "aws_profile"{
    description = "Given name in the credential file"
    type = string
    default = "summkooer"
}

variable "shared_credentials_file"{
    description = "Prodile file with credentials to the AWS account"
    type = string
    default = "C:/Users/xiaru/.aws/credentials"
}

variable "tags"{
    description = "A map of tags to add to all resources."
    type = map(string)
    default = {
        application = "serverless-api"
        env = "dev"
    }
}