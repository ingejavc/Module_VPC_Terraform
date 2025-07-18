# Mi Primera Arquitectura Modular con Terraform en AWS

¡Hola! 👋 Este proyecto te guiará en cómo crear tu primera **infraestructura en la nube** de forma automática, usando una herramienta súper genial llamada **Terraform**. No te preocupes si eres nuevo en esto, ¡lo haremos paso a paso!

---

## ¿Qué es Terraform y por qué lo usamos?

Imagina que quieres construir una casa (tu infraestructura en la nube, como una red o un servidor). Normalmente, tendrías que llamar a muchos contratistas, hacer planos a mano y supervisar todo. ¡Es mucho trabajo!

**Terraform** es como un robot constructor que sigue tus instrucciones. Tú le dices en un archivo de texto qué quieres construir (por ejemplo, "quiero una red en la nube con este nombre y este rango de IPs"), y él se encarga de hablar con tu proveedor de nube (como **Amazon Web Services - AWS**) y construirlo por ti.

Esto se llama **Infraestructura como Código (IaC)** porque estamos escribiendo nuestro "plano" de infraestructura como si fuera código de programación. ¡Es genial porque puedes:

* **Automatizar:** Construir cosas en la nube en segundos, sin clics manuales.
* **Reutilizar:** Usar el mismo plano para construir varias casas iguales (o similares).
* **Versionar:** Guardar tus planos en Git para tener un historial de cambios.
* **Colaborar:** Trabajar con otros en el mismo proyecto de infraestructura.

---

## ¿Qué vamos a construir?

Vamos a construir una **VPC (Virtual Private Cloud)** en AWS. Piensa en una VPC como tu **propia red privada y aislada** dentro de la nube. Dentro de esta VPC luego podrás poner servidores, bases de datos y más.

Usaremos una arquitectura **modular**, es decir, el código para crear la VPC estará en su propia carpeta, lo que hace más fácil su reutilización.

---

## Estructura del Proyecto

```bash
.
├── main.tf               # Módulo principal que llama a la VPC.
├── variables.tf          # Definición de variables globales.
├── terraform.tfvars      # Valores para las variables.
├── outputs.tf            # Salidas que queremos ver tras aplicar Terraform.
├── modules/
│   └── vpc/
│       ├── main.tf       # Lógica de creación de la VPC.
│       ├── variables.tf  # Variables propias del módulo VPC.
│       └── outputs.tf    # Salidas del módulo VPC.
└── README.md             # Este mismo archivo explicativo.
```

---

## Prerrequisitos

* Tener una cuenta de **AWS**.
* Instalar **Terraform**: [https://developer.hashicorp.com/terraform/downloads](https://developer.hashicorp.com/terraform/downloads)
* Configurar tus credenciales AWS:

```bash
aws configure
```

---

## Paso a Paso para Ejecutar el Proyecto

1. **Inicializar Terraform**

```bash
terraform init
```

2. **Revisar qué recursos se crearán**

```bash
terraform plan
```

3. **Aplicar la infraestructura**

```bash
terraform apply
```

4. **Destruir todo si ya no lo necesitas**

```bash
terraform destroy
```

---

## Archivos Clave

### `main.tf`

```hcl
provider "aws" {
  region = var.aws_region
}

module "main_vpc" {
  source          = "./modules/vpc"
  vpc_name        = var.vpc_name
  vpc_cidr_block  = var.vpc_cidr_block
}
```

### `variables.tf`

```hcl
variable "aws_region" {
  description = "Región de AWS donde desplegar"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "Rango CIDR para la VPC (ej: 10.0.0.0/16)"
  type        = string
}
```

### `terraform.tfvars`

```hcl
aws_region     = "us-east-1"
vpc_name       = "mi-super-vpc"
vpc_cidr_block = "10.0.0.0/16"
```

### `outputs.tf`

```hcl
output "created_vpc_id" {
  description = "ID de la VPC creada"
  value       = module.main_vpc.vpc_id
}

output "created_vpc_name" {
  description = "Nombre de la VPC creada"
  value       = module.main_vpc.vpc_name_output
}

output "used_vpc_cidr_block" {
  description = "Rango CIDR usado"
  value       = module.main_vpc.vpc_cidr_block_output
}
```

---

## Módulo VPC

### `modules/vpc/main.tf`

```hcl
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}
```

### `modules/vpc/variables.tf`

```hcl
variable "vpc_name" {
  description = "Nombre de la VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "Rango CIDR de la VPC"
  type        = string
}
```

### `modules/vpc/outputs.tf`

```hcl
output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.this.id
}

output "vpc_name_output" {
  description = "Nombre de la VPC"
  value       = var.vpc_name
}

output "vpc_cidr_block_output" {
  description = "Rango CIDR de la VPC"
  value       = var.vpc_cidr_block
}
```

---

## Tips Finales para Aprender Terraform

* Prueba con [play.withterraform.io](https://play.withterraform.io/) para practicar sin instalar nada.
* Sigue el canal oficial de HashiCorp en YouTube.
* Lee ejemplos en el [Terraform Registry](https://registry.terraform.io/modules).

---

¡Buena suerte creando tu infraestructura como un pro! ✨
