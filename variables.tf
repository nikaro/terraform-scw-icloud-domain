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

variable "dmarc_policy" {
  description = "DMARC policy."
  type        = string
  default     = "reject"
  validation {
    condition     = contains(["none", "quarantine", "reject"], var.dmarc_policy)
    error_message = "value must be one of: none, quarantine, reject"
  }
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
