live:
	poetry run uvicorn azure_api_functionapp_poc.main:app --reload

publish:
	func azure functionapp publish azure-api-functionapp-poc --python 3.9