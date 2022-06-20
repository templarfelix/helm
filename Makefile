.PHONY: default
default: help

# generate help info from comments: thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ## help information about make commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: lint
lint: ## helm lint
	@echo "run helm lint ..."
	helm lint helm-chart-sources/*

.PHONY: index
index: ## helm repo index
	@echo "run helm repo index ..."
	helm repo index --url https://templarfelix.github.io/helm/ .

.PHONY: package
package: ## helm package
	@echo "helm package helm package helm-chart-sources/*"
	helm package helm-chart-sources/*

.PHONY: deploy 
deploy: ## call all targets
	make lint
	make package 
	make index