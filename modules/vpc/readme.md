# Mi Primera Arquitectura Modular con Terraform en AWS

¡Hola! 👋 Este proyecto te guiará en cómo crear tu primera **infraestructura en la nube** de forma automática, usando una herramienta súper genial llamada **Terraform**. No te preocupes si eres nuevo en esto, ¡lo haremos paso a paso!

---

## ¿Qué es Terraform y por qué lo usamos?

Imagina que quieres construir una casa (tu infraestructura en la nube, como una red o un servidor). Normalmente, tendrías que llamar a muchos contratistas, hacer planos a mano y supervisar todo. ¡Es mucho trabajo!

**Terraform** es como un robot constructor que sigue tus instrucciones. Tú le dices en un archivo de texto qué quieres construir (por ejemplo, "quiero una red en la nube con este nombre y este rango de IPs"), y él se encarga de hablar con tu proveedor de nube (como **Amazon Web Services - AWS**) y construirlo por ti.

Esto se llama **Infraestructura como Código (IaC)** porque estamos escribiendo nuestro "plano" de infraestructura como si fuera código de programación. ¡Es genial porque puedes:

* **Automatizar:** Construir cosas en la nube en segundos, sin clics manuales.
* **Reutilizar:** Usar el mismo plano para construir varias casas iguales (o similares).
* **Versionar:** Guardar tus planos en Git (como un historial de cambios) para saber quién hizo qué y cuándo.
* **Colaborar:** Trabajar con otros en el mismo proyecto de infraestructura.

---

## ¿Qué vamos a construir?

En este proyecto, vamos a construir una **VPC (Virtual Private Cloud)** en AWS. Piensa en una VPC como tu **propia red privada y aislada** dentro de la nube de AWS. Es como si construyeras un barrio cerrado dentro de una gran ciudad. Dentro de esta VPC, podrás luego poner tus servidores, bases de datos y todo lo que necesites.

Lo haremos de forma "modular", lo que significa que el código para crear la VPC está separado en su propia carpeta (un "módulo"), lo que facilita su uso en otros proyectos.

---

## Estructura del Proyecto

Aquí te explico cómo está organizado este proyecto:

¡Absolutamente! Como arquitecto de la nube, entiendo la importancia de una infraestructura modular y bien documentada. Aquí te presento la implementación inicial de una arquitectura modular en AWS usando Terraform, centrada en un módulo de VPC, con código comentado y una guía completa para principiantes.

Estructura del Proyecto
Para mantener todo organizado, seguiremos una estructura de directorios común en proyectos Terraform:

.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── modules/
│   └── vpc/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
Archivos Terraform
main.tf (Módulo Principal)
Este es el archivo principal que usará el módulo de VPC.

Terraform

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
variables.tf (Variables Globales)
Aquí definimos las variables que usaremos en nuestro archivo main.tf.

Terraform

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
terraform.tfvars (Valores de Variables)
Este archivo contiene los valores específicos para nuestras variables. Es ideal para diferentes entornos (ej. dev.tfvars, prod.tfvars).

Terraform

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
outputs.tf (Salidas Globales)
Aquí definimos qué información del módulo queremos que se muestre una vez que Terraform termine de aplicar los cambios.

Terraform

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
Módulo vpc
Este es el corazón de nuestra solución modular para la VPC.

modules/vpc/main.tf
Terraform

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
modules/vpc/variables.tf
Estas son las variables específicas que el módulo vpc espera recibir.

Terraform

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
modules/vpc/outputs.tf
Aquí definimos las salidas que este módulo proporcionará al módulo principal.

Terraform

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
README.md (Documentación del Proyecto)
Este es el archivo clave para que cualquier persona, especialmente alguien nuevo en Terraform, entienda y use este proyecto.

Markdown

# Mi Primera Arquitectura Modular con Terraform en AWS

¡Hola! 👋 Este proyecto te guiará en cómo crear tu primera **infraestructura en la nube** de forma automática, usando una herramienta súper genial llamada **Terraform**. No te preocupes si eres nuevo en esto, ¡lo haremos paso a paso!

---

## ¿Qué es Terraform y por qué lo usamos?

Imagina que quieres construir una casa (tu infraestructura en la nube, como una red o un servidor). Normalmente, tendrías que llamar a muchos contratistas, hacer planos a mano y supervisar todo. ¡Es mucho trabajo!

**Terraform** es como un robot constructor que sigue tus instrucciones. Tú le dices en un archivo de texto qué quieres construir (por ejemplo, "quiero una red en la nube con este nombre y este rango de IPs"), y él se encarga de hablar con tu proveedor de nube (como **Amazon Web Services - AWS**) y construirlo por ti.

Esto se llama **Infraestructura como Código (IaC)** porque estamos escribiendo nuestro "plano" de infraestructura como si fuera código de programación. ¡Es genial porque puedes:

* **Automatizar:** Construir cosas en la nube en segundos, sin clics manuales.
* **Reutilizar:** Usar el mismo plano para construir varias casas iguales (o similares).
* **Versionar:** Guardar tus planos en Git (como un historial de cambios) para saber quién hizo qué y cuándo.
* **Colaborar:** Trabajar con otros en el mismo proyecto de infraestructura.

---

## ¿Qué vamos a construir?

En este proyecto, vamos a construir una **VPC (Virtual Private Cloud)** en AWS. Piensa en una VPC como tu **propia red privada y aislada** dentro de la nube de AWS. Es como si construyeras un barrio cerrado dentro de una gran ciudad. Dentro de esta VPC, podrás luego poner tus servidores, bases de datos y todo lo que necesites.

Lo haremos de forma "modular", lo que significa que el código para crear la VPC está separado en su propia carpeta (un "módulo"), lo que facilita su uso en otros proyectos.

---

## Estructura del Proyecto

Aquí te explico cómo está organizado este proyecto:

.
├── main.tf                 # Archivo principal de Terraform. Aquí le decimos a Terraform qué módulos usar.
├── variables.tf            # Aquí definimos las "preguntas" que nuestro proyecto necesita para funcionar (ej. ¿cómo se llamará la VPC?).
├── terraform.tfvars        # Aquí respondemos a esas "preguntas" con valores específicos (ej. "mi-super-vpc").
├── outputs.tf              # Aquí decimos qué información queremos que nos muestre Terraform después de crear los recursos.
├── modules/                # Esta carpeta contiene nuestros "módulos" reutilizables.
│   └── vpc/                # El módulo para crear una VPC.
│       ├── main.tf         # El código real que crea la VPC dentro del módulo.
│       ├── variables.tf    # Las "preguntas" específicas que el módulo VPC necesita.
│       └── outputs.tf      # La información que el módulo VPC devolverá.
└── README.md               # ¡Este mismo archivo que estás leyendo!

## PROMT UTILIZADO

Actúa como un arquitecto de la nube experto en Terraform y las mejores prácticas de infraestructura como código (IaC). Necesito un diseño y la implementación inicial de una arquitectura modular utilizando Terraform. Sigue estrictamente estas directrices:

**1. Diseño Modular:**
* Divide la infraestructura en módulos Terraform lógicos y reutilizables.
* Cada módulo debe encapsular un componente específico de la infraestructura (ej. VPC, subredes, instancias, bases de datos).

**2. Módulo de VPC:**
* Crea un módulo Terraform dedicado exclusivamente a la creación de una **Virtual Private Cloud (VPC)**.
* Este módulo debe aceptar las siguientes variables de entrada:
    * `vpc_name`: El nombre que se le asignará a la VPC.
    * `vpc_cidr_block`: El rango CIDR (ej. "10.0.0.0/16") para la VPC.
* El módulo de VPC debe generar como salida (outputs) la siguiente información:
    * `vpc_id`: El ID único de la VPC creada.
    * `vpc_name_output`: El nombre asignado a la VPC.
    * `vpc_cidr_block_output`: El rango CIDR utilizado para la VPC.

**3. Variables y Archivos de Configuración:**
* Define todas las entradas necesarias para el módulo principal y los submódulos como **variables de Terraform**.
* Organiza estas variables en los siguientes archivos:
    * `variables.tf`: Para la definición de las variables (tipo, descripción, valor por defecto si aplica).
    * `terraform.tfvars`: Para asignar los valores específicos a las variables (ej. `vpc_name = "mi-vpc-prod"`).

**4. Documentación de Código (Comentarios en el Código):**
* **Comenta cada bloque de recurso, variable, output y módulo** dentro de los archivos `.tf`.
* Los comentarios deben explicar:
    * **Qué hace** el bloque de código.
    * **Por qué** se está haciendo de esa manera (si no es obvio).
    * **Variables de entrada/salida importantes** y su propósito.
    * **Cualquier suposición o decisión de diseño clave.**
* El objetivo es que cualquier desarrollador, incluso sin experiencia previa con este código, pueda entender su propósito y funcionamiento leyendo los comentarios.

**5. Mejores Prácticas:**
* Utiliza una estructura de directorios recomendada para proyectos Terraform.
* Asegura que el código sea claro, legible y esté bien comentado.
* Implementa el principio de "mínimo privilegio" donde sea aplicable.
* Considera la inmutabilidad de la infraestructura.

**6. Documentación Externa (README.md):**
* Crea un archivo `README.md` exhaustivo y fácil de entender.
* El README.md debe estar dirigido a una **persona joven (16-20 años) con poco conocimiento previo de Terraform o la nube**.
* Debe incluir:
    * Una **introducción clara** a qué es Terraform y la infraestructura como código (IaC), explicando por qué es útil.
    * Una **explicación sencilla** de la estructura del proyecto y los módulos.
    * **Prerrequisitos** para ejecutar el proyecto (ej. instalar Terraform, configurar credenciales de AWS/GCP/Azure).
    * Un **caso de uso paso a paso** para ejecutar este proyecto de Terraform, incluyendo comandos específicos para:
        * Inicializar Terraform (`terraform init`).
        * Planificar cambios (`terraform plan`).
        * Aplicar cambios (`terraform apply`).
        * Destruir la infraestructura (`terraform destroy`).
    * **Consejos adicionales** para aprender más sobre Terraform y la nube.

**7. Plataforma Cloud:**
* Assume que la plataforma cloud a utilizar es **AWS**. (Si necesitas otra, por favor especifica).

Tu respuesta debe incluir el código Terraform para el módulo de VPC, los archivos `variables.tf`, `terraform.tfvars` de ejemplo para el módulo principal, y el contenido completo del archivo `README.md`