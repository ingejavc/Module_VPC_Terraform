# modules/vpc/main.tf

# Recurso de AWS para crear una VPC (Virtual Private Cloud).
# Este bloque define cómo Terraform debe crear la VPC en su cuenta de AWS.
resource "aws_vpc" "this" {
  # El bloque CIDR de la VPC. Esto define el rango de direcciones IP para la red.
  # El valor se toma de la variable 'vpc_cidr_block' que recibe este módulo.
  cidr_block = var.vpc_cidr_block

  # Habilita la resolución de nombres de DNS dentro de la VPC.
  # Esto permite que las instancias dentro de la VPC puedan resolver nombres de host de otras instancias.
  enable_dns_hostnames = true

  # Habilita el soporte de DNS dentro de la VPC.
  # Esencial para que el servicio de DNS de AWS (Route 53) funcione correctamente dentro de la VPC.
  enable_dns_support   = true

  # Etiquetas (Tags) para identificar la VPC.
  # Las etiquetas son pares clave-valor que ayudan a organizar y encontrar recursos en AWS.
  # 'Name' es una etiqueta común para darle un nombre amigable al recurso.
  tags = {
    Name = var.vpc_name # El nombre de la VPC se toma de la variable 'vpc_name' que recibe este módulo.
  }
}