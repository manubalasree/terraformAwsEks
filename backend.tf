# create backend confoguration https://www.padok.fr/en/blog/terraform-s3-bucket-aws
# sticking to partial config expect vars to be passed on init
/*
terraform init -backend-config="<buckey name>" \
-backend-config="key=terraformawsvpc/terraform.tfstate" \
-backend-config="region=us-east-2" \
-backend-config="encrypt=true" \
-backend-config="kms_key_id=<key id>"
*/

#backend encrypted with customer managed KMS
terraform {
  backend "s3" {}
}