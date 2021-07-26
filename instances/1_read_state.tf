# Reading Remote State for layer 1 infrastructure
data "terraform_remote_state" "network_configuration" {
  backend = "s3"

  config =  {
    bucket = var.remote_state_bucket
    key = var.remote_state_key
    region = var.region
  }

}