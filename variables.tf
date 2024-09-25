variable "zone" {
  description = "Zone where to publish records."
  type        = string
}

variable "mx_priority" {
  description = "MX records priority."
  type        = number
  default     = 10
}

variable "spf_includes" {
  description = "SPF includes."
  type        = list(string)
  default     = ["icloud.com"]
}

variable "spf_policy" {
  description = "SPF policy."
  type        = string
  default     = "~all"
  validation {
    condition     = contains(["~all", "-all", "?all"], var.spf_policy)
    error_message = "value must be one of: ~all, -all, ?all"
  }
}

variable "dmarc_p" {
  description = "DMARC policy."
  type        = string
  default     = "reject"
  validation {
    condition     = contains(["none", "quarantine", "reject"], var.dmarc_p)
    error_message = "value must be one of: none, quarantine, reject"
  }
}

variable "dmarc_pct" {
  description = "DMARC policy percentage."
  type        = number
  default     = 100
  validation {
    condition     = var.dmarc_pct >= 0 && var.dmarc_pct <= 100
    error_message = "value must be between 0 and 100"
  }
}

variable "dmarc_adkim" {
  description = "DMARC DKIM alignment."
  type        = string
  default     = "r"
  validation {
    condition     = contains(["r", "s"], var.dmarc_adkim)
    error_message = "value must be one of: r (for relaxed), s (for strict)"
  }
}

variable "dmarc_aspf" {
  description = "DMARC SPF alignment."
  type        = string
  default     = "r"
  validation {
    condition     = contains(["r", "s"], var.dmarc_adkim)
    error_message = "value must be one of: r (for relaxed), s (for strict)"
  }
}

variable "dmarc_rua" {
  description = "DMARC aggregate report email."
  type        = string
  default     = ""
}

variable "dmarc_fo" {
  description = "DMARC forensic options"
  type        = string
  default     = ""
}

variable "dmarc_ruf" {
  description = "DMARC forensic report email."
  type        = string
  default     = ""
}

variable "smtp_tls_rua" {
  description = "SMTP TLS reporting"
  type        = string
  default     = ""
}

variable "domain_verif_data" {
  description = "Domain verification data."
  type        = string
}

variable "ttl" {
  description = "TTL for records."
  type        = number
  default     = 3600
}
