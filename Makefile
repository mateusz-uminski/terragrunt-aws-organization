.PHONY: lint
lint:
	terraform fmt -check -recursive
	terragrunt hclfmt hclfmt --terragrunt-check

.PHONY: clean
clean: remove-cache remove-locks

.PHONY: remove-cache
remove-cache:
	find . -type d -name ".terraform" -prune -exec rm -rf {} \;
	find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;

.PHONY: remove-locks
remove-locks:
	find . -name ".terraform.lock.hcl" -prune -exec rm -f {} \;
