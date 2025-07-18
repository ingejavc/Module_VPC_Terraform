# terraform.tfvars

# Asigna un valor específico a la variable 'aws_region'.
# En este caso, la infraestructura se creará en la región us-east-1 (Norte de Virginia).
aws_region = "us-east-1"

# Asigna un valor específico a la variable 'vpc_name'.
# Este será el nombre que verá en la consola de AWS para su VPC.
vpc_name = "mi-super-vpc"

# Asigna un valor específico a la variable 'vpc_cidr_block'.
# Este es el rango de IPs para su VPC. Un /16 es un rango grande, ideal para empezar.
vpc_cidr_block = "10.0.0.0/16"