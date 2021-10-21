# SGIT is a tool for git that is used to manage many secondary git repos inside a primary git repo

## ! NOTE: This assumes that git.mk is included by the calling makefile

## Override variables
# The folder in your source code you want to create the make template in. ( e.g: ./2d/animation)
SGIT_TEMPLATE_SRC_FSPATH=sgit-test-folder
# The github repo URL you want to use ( e.g: https://github.com/audrenbdb/goinstall )
SGIT_TEMPLATE_REPO_URL=Pass in as an arg !
# The makefile template you want to use ( e.g: gio )
SGIT_TEMPLATE_ARCHITYPE_NAME=gio

## Computed variables
# PERFECT :) https://www.systutorials.com/how-to-get-a-makefiles-directory-for-including-other-makefiles/
_SGIT_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
_SGIT_TEMPLATES_SOURCE=$(_SGIT_SELF_DIR)/sgit-templates
_SGIT_TEMPLATES_TARGET=$(SGIT_TEMPLATE_SRC_FSPATH)/_sgit-templates
_SGIT_TEMPLATE_ARCHITYPE_FSPATH=$(_SGIT_TEMPLATES_TARGET)/$(SGIT_TEMPLATE_ARCHITYPE_NAME)

sgit-print:
	@echo
	@echo --- SGIT ---
	@echo Deps:
	@echo GIT_BIN: 					Found $(GIT_BIN) at : $(shell which $(GIT_BIN))

	@echo
	@echo Override variables:
	@echo SGIT_TEMPLATE_REPO_URL: 	$(SGIT_TEMPLATE_REPO_URL)
	@echo SGIT_TEMPLATE_SRC_FSPATH: $(SGIT_TEMPLATE_SRC_FSPATH)
	@echo SGIT_TEMPLATE: 			$(SGIT_TEMPLATE)

	@echo
	@echo Computed variables:
	@echo _SGIT_SELF_DIR:					$(_SGIT_SELF_DIR)
	@echo _SGIT_TEMPLATES_SOURCE: 			$(_SGIT_TEMPLATES_SOURCE)
	@echo _SGIT_TEMPLATES_TARGET: 			$(_SGIT_TEMPLATES_TARGET)
	@echo _SGIT_TEMPLATE_ARCHITYPE_FSPATH: 	$(_SGIT_TEMPLATE_ARCHITYPE_FSPATH)
	@echo



## Given a github repo path generates a makefile from a template
sgit-maketemplate:

	@echo installing sgit templates 
	# copy templates up to working target
	mkdir -p $(_SGIT_TEMPLATES_TARGET)
	cp -r $(_SGIT_TEMPLATES_SOURCE)/* $(_SGIT_TEMPLATES_TARGET)/
	@echo installed sgit templates  at : $(_SGIT_TEMPLATES_TARGET)

	@echo templating your chosen template architytpe
	stat $(_SGIT_TEMPLATES_TARGET)/$(SGIT_TEMPLATE_ARCHITYPE_NAME)/makefile
	# TODO do find a replace in the makefile and .gitignore file.

	

## Deletes all repos recursively found using the "gitty" prefix.
sgit-clean:
	$(MAKE) _sgit-find


## Finds searches the workpath for all git code folders.
_sgit-find:
	# TODO It must use the "gitty" prefix in the search path. 
	# TODO change this to be recursive

	@echo Search Prefix : $(GIT_REPO_PREFIX)

	for a in $$(ls); do \
		if [ -d $$a ]; then \
			echo "found folder $$a"; \
		fi; \
	done;
	echo "Done!"


## git finds and delete searches AND deletes all git code folders matching either "origin" or "upstream"
_sgit-find-and-delete:
	for a in $$(ls); do \
		if [ -d $$a ]; then \
			echo "found folder:  $$a"; \
			if [ $$a = origin ]; then \
				echo "  deleting folder: $$a"; \
			fi; \
			if [ $$a = upstream ]; then \
				echo "  deleting folder: $$a"; \
			fi; \
		fi; \
	done;
	echo "Done!"