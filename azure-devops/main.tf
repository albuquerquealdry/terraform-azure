terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "=0.1.7"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.75.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuredevops" {
  org_service_url =  var.org_service_url 
  personal_access_token =  var.personal_access_token
}

resource "azuredevops_project" "project" {
  name = var.project_name
  description  =  var.description
}

resource "azuredevops_git_repository" "repository" {
  project_id = azuredevops_project.project.id
  name       = var.repository_name
  initialization {
    init_type = "Clean"
  }
}

resource "azuredevops_build_definition" "build_definition" {
  project_id = azuredevops_project.project.id
  name       =  var.build_name
  path       = "\\"

  repository {
    repo_type   = "TfsGit"
    repo_id     = azuredevops_git_repository.repository.id
    branch_name = azuredevops_git_repository.repository.default_branch
    yml_path    = "azure-pipelines.yml"
  }
}