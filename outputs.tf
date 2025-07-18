# outputs.tf

# Muestra el ID de la VPC creada.
# Esta salida toma el valor del output 'vpc_id' del módulo 'main_vpc'.
# Es útil para referenciar la VPC desde otros lugares o simplemente para verificar que se creó correctamente.
output "created_vpc_id" {
  description = "El ID de la VPC que ha sido creado." # Descripción clara del output.
  value       = module.main_vpc.vpc_id                 # Se refiere al output 'vpc_id' de nuestro módulo 'main_vpc'.
}

# Muestra el nombre asignado a la VPC.
# Tomamos el valor de 'vpc_name_output' desde el módulo.
output "created_vpc_name" {
  description = "El nombre de la VPC que ha sido creado." # Descripción clara del output.
  value       = module.main_vpc.vpc_name_output          # Se refiere al output 'vpc_name_output' de nuestro módulo 'main_vpc'.
}

# Muestra el rango CIDR utilizado por la VPC.
# Tomamos el valor de 'vpc_cidr_block_output' desde el módulo.
output "used_vpc_cidr_block" {
  description = "El rango CIDR utilizado por la VPC." # Descripción clara del output.
  value       = module.main_vpc.vpc_cidr_block_output  # Se refiere al output 'vpc_cidr_block_output' de nuestro módulo 'main_vpc'.
}