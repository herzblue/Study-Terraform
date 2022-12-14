variable "names" {
  description = "A list of names"
  type        = list(string)
  default     = ["gasida", "akbun", "ygpark"]
}

output "upper_names" {
  value = [for name in var.names : upper(name)]
}

output "short_upper_names" {
  value = [for name in var.names : upper(name) if length(name) < 5]
}

variable "hero_thousand_faces" {
  description = "map"
  type        = map(string)
  default     = {
    gasida    = "hero"
    akbun     = "love interest"
    ygpark    = "mentor"
  }
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}
