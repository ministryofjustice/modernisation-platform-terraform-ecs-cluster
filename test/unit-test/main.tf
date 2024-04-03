module "unit_test" {
  #checkov:skip=CKV_TF_1:Module registry does not support commit hashes for versions
  source = "../..//cluster"
  name   = "unit-test"
  tags   = local.tags
}
