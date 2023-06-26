provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {}
}

module "cdn_configuration" {
    source = "../../modules/cdn"
    domain_name         = "${module.webstatic_bucketx.bucket}.s3.${var.aws_region}.amazonaws.com"
    origin_id           = "${var.bucket_namex}-${var.environment}.${var.domain}"
    web_aliases         = ["myviapath-qa.${var.domain}"]
    env                 = var.environment
    acm_certificate_arn = var.acm_arn_us_east-1
    origin_path         = ""
    origin_bucket_arn   = module.webstatic_bucketx.arn
    origin_bucket_id    = module.webstatic_bucketx.id
    OAI_id              = module.webstatic_OAI.id
    resource_policy     = "arn:aws:s3:::${var.bucket_namex}-${var.environment}.${var.domain}/*"
}

module "webstatic_bucketx" {
  source        = "../../modules/s3/"
  domain_name   = "${var.bucket_namex}-${var.environment}.${var.domain}"
  force_destroy = true
}

module "webstatic_OAI" {
  source      = "../../modules/OAI/"
  domain_name = var.domain
}

data "aws_route53_zone" "hosted_zone" {
  name = var.domain
}

module "webstatic_record" {
  source       = "../../modules/route53/"
  zone_id      = data.aws_route53_zone.hosted_zone.zone_id
  # name_record  = "${var.bucket_namex}-${var.environment}.${var.domain}"
  name_record  = "myviapath-qa.${var.domain}"
  type_record  = "CNAME"
  ttl_record   = "3600"
  value_record = [module.cdn_configuration.cfn_domain_name]
}