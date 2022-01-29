from fastapi import APIRouter
from azure_api_functionapp_poc.api import version

api_router = APIRouter()

api_router.include_router(version.router, tags=["version"])
