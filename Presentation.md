#+author: Ali Achille Traore
#+title: From Static Website Deployment on AWS to Advanced Infrastructure as Code with Terraform
#+date: <2024-02-25 Sun>

* Introduction
This document navigates through deploying static websites from manual deployment on AWS, to automated Terraform deployment on Azure, and advances into Infrastructure as Code practices with Terraform, including the Terraform Cloud Development Kit (CDKTF).

* Part 1: Build and Deploy a Web-Based Resume Using AWS
** Step 0: Manual work
Deploy a simple resume website using AWS services such as S3, Route 53, AWS Certificate Manager, and CloudFront. This beginner-friendly and cost-effective approach demonstrates the basics of cloud deployment.

** Prerequisites
- GitHub account for version control.
- Visual Studio Code or preferred code editor.
- AWS account.
- Git installed on the local machine.

** Deployment Steps
1. Build Your Resume with HTML, CSS, and JavaScript.
2. Upload to AWS S3 and Configure for Static Website Hosting.
3. Use Route 53 for a Custom Domain.
4. Set Up SSL/TLS with AWS Certificate Manager.
5. Create a CloudFront Distribution.
- Optionally, integrate with GitHub for Continuous Deployment.

** Conclusion
- Pros: Beginner-friendly, cost-effective, customizable.
- Cons: Manual process, AWS-specific, requires regular maintenance.

* Part 2: Azure Online Resume Deployment with Terraform
** Step 1: Terraform HCL with hardcoded values
Deploy an online resume on Azure using Terraform, utilizing Azure's Storage Account, CDN, and DNS for global distribution.

** Prerequisites
- Azure account with an active subscription.
- Terraform installed on the local machine.
- Basic knowledge of Terraform and Azure services.
- Azure CLI installed.
- Git installed on the local machine.

** Deployment Steps
Setup provider configuration, variables, and resources like Resource Group, Storage Account, CDN Profile, and CDN Endpoint.
Refer to Twelve-Factor App principles and Terraform Input Variables for dynamic configurations.

*** Provider Configuration
#+BEGIN_SRC terraform
provider "azurerm" {
  features {}
}
#+END_SRC

*** Variables Definition and Local Values
#+BEGIN_SRC terraform
variable "location" {
  description = "The Azure region where resources will be created."
  default     = "East US"
}

variable "storage_account_name" {
  description = "The name of the storage account for hosting the resume site."
  default     = "achilledevopsdemo123" # Ensure this is unique
}

variable "resource_group_name" {
  description = "The name of the resource group."
  default     = "AchilleDevOpsDemoRG"
}

variable "cdn_profile_name" {
  description = "The name of the CDN profile."
  default     = "AchilleDevOpsCDNProfile"
}

variable "cdn_endpoint_name" {
  description = "The name of the CDN endpoint."
  default     = "AchilleDevOpsCDNEndpoint"
}
#+END_SRC

*** Resource Group
#+BEGIN_SRC terraform
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
#+END_SRC

*** Storage Account
#+BEGIN_SRC terraform
resource "azurerm_storage_account" "resume" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  static_website {
    index_document = "index.html"
  }
}
#+END_SRC

*** CDN Profile and Endpoint
#+BEGIN_SRC terraform
resource "azurerm_cdn_profile" "resume_cdn_profile" {
  name                = var.cdn_profile_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "resume_cdn_endpoint" {
  name                = var.cdn_endpoint_name
  profile_name        = azurerm_cdn_profile.resume_cdn_profile.name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  origin {
    name      = "resumeOrigin"
    host_name = local.storage_account_hostname
  }
}
#+END_SRC

** Outputs
*** Website URL and CDN Endpoint Hostname
#+BEGIN_SRC terraform
output "static_website_url" {
  value = azurerm_storage_account.resume.primary_web_endpoint
}
output "cdn_endpoint_hostname" {
  value = azurerm_cdn_endpoint.resume_cdn_endpoint.host_name
}
#+END_SRC

** Pros and Cons of Using Terraform
- Pros: Infrastructure as Code, provider agnostic, state management, modular design.
- Cons: Learning curve, complexity in state management, performance issues for large infrastructures.

* Part 3: Terraform Progression
** Step 4: Terraform CDK Conversion
The Terraform Cloud Development Kit (CDKTF) allows you to define cloud infrastructure using familiar programming languages. This step covers the setup and basic usage of CDKTF with a focus on a Python environment, showcasing the initial setup, project initialization, and resource deployment.

*** CDKTF Setup on Windows
Before you begin, ensure you have Node.js and Python installed on your machine. The CDKTF relies on both to execute infrastructure as code.

**** Preparation and Initialization
First, install the CDKTF CLI globally using npm, initialize a new project, and prepare your environment for development.

#+BEGIN_SRC sh
npm install -g cdktf-cli
mkdir cdktf-project
cd cdktf-project
cdktf init --template="python-pip" --local --project-name="MyCDKTFProject" --project-description="My CDKTF project" --main-stack="main"
#+END_SRC

This command initializes a new CDKTF project using Python. The `--local` flag is used to store the state locally, but for production, you should configure remote state storage.

**** Activate Python Virtual Environment
CDKTF projects use a Python virtual environment to manage dependencies. Activate it with the following command:

#+BEGIN_SRC sh
source .venv/bin/activate
#+END_SRC

**** Install Dependencies
After initializing your project, install the necessary dependencies, including CDKTF providers for AWS, Azure, and Google Cloud.

#+BEGIN_SRC sh
pip install cdktf cdktf-cli constructs
cdktf get
#+END_SRC

`cdktf get` generates bindings for the providers specified in `cdktf.json`.

**** Define Infrastructure
Create your infrastructure using Python. For example, define an AWS S3 bucket in `main.py`:

#+BEGIN_SRC python
from constructs import Construct
from cdktf import App, TerraformStack
from imports.aws import AwsProvider, s3

class MyStack(TerraformStack):
    def __init__(self, scope: Construct, ns: str):
        super().__init__(scope, ns)
        AwsProvider(self, 'Aws', region='us-east-1')
        
        s3.Bucket(self, 'MyBucket',
            bucket='my-unique-bucket-name'
        )

app = App()
MyStack(app, "my-stack")
app.synth()
#+END_SRC

This code snippet defines a stack with a single S3 bucket.

**** Deploy Infrastructure
With your infrastructure defined, plan and deploy it using the CDKTF CLI.

#+BEGIN_SRC sh
cdktf plan
cdktf deploy
#+END_SRC

`cdktf plan` generates an execution plan, showing what actions CDKTF will perform. `cdktf deploy` provisions the resources in your cloud provider.

**** Clean Up Resources
To avoid incurring unnecessary charges, destroy the resources when you're done.

#+BEGIN_SRC sh
cdktf destroy
#+END_SRC

`cdktf destroy` removes the deployed resources.

*** CDKTF Windows Setup
For Windows users, the process is similar. Ensure PowerShell is used for command execution, and activate the Python virtual environment with:

#+BEGIN_SRC powershell
.venv\Scripts\Activate.ps1
#+END_SRC

Follow the rest of the steps as outlined above, adjusting paths and commands as necessary for the Windows environment.

* Repository of Resources for Further Learning
Provides comprehensive links and resources for AWS, Azure, Terraform, Git, GitHub, GitLab, HTML, and CSS.

* HTML and CSS Resources for Better Web Development
Highlights tutorials, courses, and books for learning HTML and CSS.

* Conclusion
From deploying a static website on AWS to adopting advanced Infrastructure as Code practices with Terraform and Terraform CDK, this guide equips developers with the knowledge to manage and scale cloud infrastructure efficiently.
