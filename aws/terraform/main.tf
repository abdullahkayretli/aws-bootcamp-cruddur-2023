module "docker-instance" {
  source  = "abdullahkayretli/docker-instance/aws"
  version = "0.0.1"
  key_name = "Server-Key" # insert key name variable here
}
