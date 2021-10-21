# https://github.com/nektos/act

# Runs github actions locally. 

# Needs docker.

GITHUB_ACT_BIN=act
GITHUB_ACT_BIN_VERSION=v0.2.24

# variables
GITHUB_EX_PATH=?


# PERFECT :) https://www.systutorials.com/how-to-get-a-makefiles-directory-for-including-other-makefiles/
SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

## act print, outputs all variables needed to run caddy
github-print:
	@echo
	@echo ### ACT ###
	@echo -- Bins --
	@echo GITHUB_ACT_BIN installed at : $(shell which $(GITHUB_ACT_BIN))
	@echo GITHUB_ACT_BIN_VERSION : $(GITHUB_ACT_BIN_VERSION)
	@echo
	@echo -- Variables --
	
	@echo GITHUB_EX_PATH: $(GITHUB_EX_PATH)
	@echo - the full path where you want to run ACT from. 
	@echo
	@echo -- Templates --
	@echo none for this makefile
	
	
## Installs act
github-dep:
	@echo
	@echo installing ACT tool
	@echo installed ACT at : $(shell which $(GITHUB_ACT_BIN))
	go install -ldflags="-s -w" github.com/nektos/act@$(GITHUB_ACT_BIN_VERSION)