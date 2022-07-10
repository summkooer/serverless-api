variable "shared_config_files" {
    description = "Profile file with config to the AWS account"
    type = string
    default = "C:/Users/xiaru/.aws/config"
}

variable "shared_credentials_files" {
    description = "Profile file with credentials to the AWS account"
    type = string
    default = "C:/Users/xiaru/.aws/credentials"
}

variable "tags" {
    description = "A map of tags to add to all resources."
    type = map(string)
    default = {
        application = "serverless-api-test"
        env = "dev"
    }
}