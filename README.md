# Azure Function App PoC

Host Python FastAPI with static site as single entry point on Azure Function App

## Local development

- Install poetry
- `(poetry install && poetry shell)`
- `make live`

## Create infrastructure

- Install Azure CLI
- Install Terraform
- `az login`
- `az group create -l northeurope -n azure-api-funcitonapp-poc`
- `(cd infra && terraform apply --auto-approve)`

## Publish

- Install Azure Functions Core Tools (func)
- `func azure functionapp publish azure-api-functionapp-poc --python 3.9`