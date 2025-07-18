# modules/vpc/outputs.tf

# Salida que expone el ID de la VPC creada.
# `aws_vpc.this.id` hace referencia al ID del recurso 'aws_vpc' que nombramos como 'this'.
# Es útil para que otros módulos o el módulo principal puedan referenciar esta VPC.
output "vpc_id" {
  description = "El ID de la VPC creada." # Descripción clara del output.
  value       = aws_vpc.this.id           # Valor: el ID del recurso aws_vpc.
}

# Salida que expone el nombre de la VPC.
# Simplemente reenvía el nombre de la VPC que se le pasó como entrada.
output "vpc_name_output" {
  description = "El nombre asignado a la VPC." # Descripción clara del output.
  value       = var.vpc_name                   # Valor: el nombre que se usó para la VPC.
}

# Salida que expone el rango CIDR de la VPC.
# Simplemente reenvía el rango CIDR que se le pasó como entrada.
output "vpc_cidr_block_output" {
  description = "El rango CIDR utilizado para la VPC." # Descripción clara del output.
  value       = var.vpc_cidr_block                   # Valor: el bloque CIDR que se usó para la VPC.
}