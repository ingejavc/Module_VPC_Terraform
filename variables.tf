# variables.tf

# Define la variable para la región de AWS.
# Esta variable permite configurar en qué región de AWS se desplegará la infraestructura.
variable "aws_region" {
  description = "La región de AWS donde se desplegará la infraestructura." # Descripción clara para entender su propósito.
  type        = string                                                     # El tipo de dato es cadena de texto.
  default     = "us-east-1"                                                # Valor por defecto si no se especifica.
}

# Define la variable para el nombre de la VPC.
# Usaremos esta variable para nombrar nuestra VPC en AWS.
variable "vpc_name" {
  description = "El nombre que se le asignará a la VPC." # Descripción clara.
  type        = string                                   # Tipo de dato cadena.
}

# Define la variable para el bloque CIDR de la VPC.
# Este es el rango de direcciones IP privadas que tendrá nuestra VPC.
variable "vpc_cidr_block" {
  description = "El rango CIDR para la VPC (ej. 10.0.0.0/16)." # Descripción clara.
  type        = string                                         # Tipo de dato cadena.
}