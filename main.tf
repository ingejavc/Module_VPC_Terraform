# main.tf

# Define el proveedor de la nube a utilizar.
# En este caso, estamos usando AWS.
# Esto le dice a Terraform que vamos a gestionar recursos en Amazon Web Services.
provider "aws" {
  region = var.aws_region # La región de AWS se toma de una variable para hacerla configurable.
}

# Define el módulo de VPC.
# Aquí es donde instanciamos nuestro módulo 'vpc' que está en la carpeta 'modules/vpc'.
# Esto nos permite reutilizar el código de la VPC en diferentes entornos o proyectos.
module "main_vpc" {
  # La ruta al módulo. Indica dónde Terraform debe buscar el código de este módulo.
  source = "./modules/vpc"

  # Pasa las variables de entrada al módulo de VPC.
  # Estos valores se definen en el archivo 'terraform.tfvars' para una fácil configuración.
  vpc_name        = var.vpc_name        # Nombre para la VPC.
  vpc_cidr_block  = var.vpc_cidr_block  # Rango de direcciones IP para la VPC.
}