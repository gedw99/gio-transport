# https://github.com/jerson/pgrok

# PGROK



PGROK_BIN=pgrok
PGROKD_BIN=pgrokd

# Override variables
PGROK_SRC_PATH=pgrok

# Constant variables
_PGROK_PORT=80

# Computed variables
# PERFECT :) https://www.systutorials.com/how-to-get-a-makefiles-directory-for-including-other-makefiles/
SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
_PGROK_TEMPLATES_SOURCE=$(SELF_DIR)/pgrok-templates
_PGROK_TEMPLATES_TARGET=$(PGROK_SRC_PATH)/_pgrok-templates



## pgrok print, outputs all variables needed to run pgrok
pgrok-print:
	@echo
	@echo --- PGROK ---

	@echo Deps:
	@echo PGROK_BIN: 				$(PGROK_BIN) installed pgrok at : $(shell which $(PGROK_BIN))
	@echo PGROK_BIN_MKCERT: 		$(PGROK_BIN_MKCERT) installed mkcert at : $(shell which $(PGROK_BIN_MKCERT))
	@echo
	@echo Override variables:
	@echo PGROK_SRC_PATH: 			$(PGROK_SRC_PATH)
	@echo
	@echo Constant variables:
	@echo _PGROK_PORT:	$(_PGROK_PORT)
	@echo - runs a basic file server in debug mode.
	@echo
	@echo Computed variables:
	@echo SELF_DIR:					$(SELF_DIR)
	@echo _PGROK_TEMPLATES_SOURCE: 	$(_PGROK_TEMPLATES_SOURCE)
	@echo _PGROK_TEMPLATES_TARGET: 	$(_PGROK_TEMPLATES_TARGET)
	@echo


## pgrok dep installs the pgrok and mkcert binary to the go bin
## cand copies the templates up into your templates working directory
# Useful where you want to grab them and customise.
pgrok-dep:
	@echo
	@echo installing pgrok client binary
	#go install github.com/jerson/pgrok/cmd/pgrok@latest
	brew install jerson/tap/pgrok
	@echo installed pgrok at : $(shell which $(PGROK_BIN))

	@echo
	@echo installing pgrok serer binary
	brew install jerson/tap/pgrokd
	@echo installed pgrokd at : $(shell which $(PGROKD_BIN))


## pgrok run starts the pgrok client using your pgrok.yml
pgrok-run:
	cd $(PGROK_SRC_PATH) && $(PGROK_BIN) start-all -config pgrok.yml

## pgrokd run starts the pgrokd server using your pgrok.yml
pgrokd-run:
	cd $(PGROK_SRC_PATH) && $(PGROKD_BIN) start-all -config pgrok.yml

	

