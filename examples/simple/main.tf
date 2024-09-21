module "icloud_example_net" {
  source            = "github.com/nikaro/terraform-scw-icloud-domain?ref=1.0.0"
  zone              = "example.net"
  domain_verif_data = "xxxxxxxxxxxxxxxx"
}
