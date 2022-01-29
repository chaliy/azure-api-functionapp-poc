from fastapi import FastAPI

from azure_api_functionapp_poc.config import settings
from azure_api_functionapp_poc.api.api import api_router

app = FastAPI(
    title="Azure API FunctionApp PoC API",
    version="1.0.0",
    openapi_url=f"/api/openapi.json",
)

app.include_router(api_router, prefix="/api")
