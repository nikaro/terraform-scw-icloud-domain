terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.45"
    }
  }
  required_version = ">= 1.0"
}

resource "scaleway_domain_record" "mx" {
  for_each = toset(["1", "2"])
  dns_zone = var.zone
  type     = "MX"
  ttl      = var.ttl
  data     = "${var.mx_priority} mx0${each.key}.mail.icloud.com."
}

resource "scaleway_domain_record" "verif" {
  dns_zone = var.zone
  type     = "TXT"
  ttl      = var.ttl
  data     = "apple-domain=${var.domain_verif_data}"
}

resource "scaleway_domain_record" "spf" {
  dns_zone = var.zone
  type     = "TXT"
  ttl      = var.ttl
  data     = "v=spf1 ${join(" ", [for i in var.spf_includes : "include:${i}"])} ${var.spf_policy}"
}

resource "scaleway_domain_record" "dkim" {
  dns_zone = var.zone
  name     = "sig1._domainkey"
  type     = "CNAME"
  ttl      = var.ttl
  data     = "sig1.dkim.${var.zone}.at.icloudmailadmin.com."
}

resource "scaleway_domain_record" "dmarc" {
  dns_zone = var.zone
  name     = "_dmarc"
  type     = "TXT"
  ttl      = var.ttl
  data     = "v=DMARC1; p=${var.dmarc_p}; pct=${var.dmarc_pct}; adkim=${var.dmarc_adkim}; aspf=${var.dmarc_aspf}; rua=${var.dmarc_rua}; fo=${var.dmarc_fo}; ruf=${var.dmarc_ruf}"
}

resource "scaleway_domain_record" "tls_report" {
  dns_zone = var.zone
  name     = "_smtp._tls"
  type     = "TXT"
  ttl      = var.ttl
  data     = "v=TLSRPTv1; rua=${var.smtp_tls_rua}"
}

resource "scaleway_domain_record" "srv_submission" {
  dns_zone = var.zone
  name     = "_submission._tcp"
  type     = "SRV"
  ttl      = var.ttl
  data     = "0 1 587 smtp.mail.me.com."
}

resource "scaleway_domain_record" "srv_imaps" {
  dns_zone = var.zone
  name     = "_imaps._tcp"
  type     = "SRV"
  ttl      = var.ttl
  data     = "0 1 993 imap.mail.me.com."
}
