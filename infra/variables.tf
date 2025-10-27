variable "port" {
  description = "Porta de inicialização do servidor"
  type        = string
  default     = "3000"
}

variable "app_db_password" {
  description = "Password do usuário da aplicação"
  type = string
}

variable "user" {
  description = "Usuário da aplicação"
  type        = string
}

variable "db_pass" {
  description = "Password do usuário da aplicação"
  type        = string
}

variable "host" {
  description = "Endereço do database"
  type        = string
}

variable "db_port" {
  description = "Porta do database"
  type        = string
}

variable "database" {
  description = "Database da aplicação"
  type        = string
}

variable "postgres_password" {
  description = "Password de inicialização do PostgreSQL"
  type        = string
}