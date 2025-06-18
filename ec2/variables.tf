variable "public_key_path" {
  description = "Path to the SSH public key"
  type        = string
}

#keeps the SSH key reusable and externalized from code.