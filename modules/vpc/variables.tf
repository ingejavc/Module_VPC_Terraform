# modules/vpc/variables.tf

# Variable de entrada para el nombre de la VPC.
# Este nombre se usará para la etiqueta 'Name' de la VPC en AWS.
variable "vpc_name" {
  description = "El nombre que se le asignará a la VPC." # Descripción clara de la variable.
  type        = string                                   # Tipo de dato: cadena de texto.
}

# Variable de entrada para el rango CIDR de la VPC.
# Este es el bloque de direcciones IP que la VPC utilizará.
variable "vpc_cidr_block" {
  description = "El rango CIDR para la VPC (ej. 10.0.0.0/16)." # Descripción clara de la variable.
  type        = string                                         # Tipo de dato: cadena de texto.
}