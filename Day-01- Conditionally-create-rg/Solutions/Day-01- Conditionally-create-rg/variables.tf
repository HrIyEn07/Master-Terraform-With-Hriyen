variable "environment" {
  type = object({
    name   = string
    type   = string  # dev, qa, staging, prod
    region = object({
      primary   = string
      secondary = string
    })
  })
}

variable "resource_group" {
    type = object({
      name = string
    })
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all resources"
}