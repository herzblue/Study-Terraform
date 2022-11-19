variable "names" {
  description = "Names to render"
  type        = list(string)
  default     = ["gasida", "akbun", "ygpark"]
}

output "for_directive_index" {
  value = "%{ for i, name in var.names }(${i}) ${name}, %{ endfor }"
}
