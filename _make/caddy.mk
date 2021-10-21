# CADDY



CADDY_BIN=caddy
CADDY_BIN_MKCERT=mkcert

# Override variables
CADDY_SRC_FSPATH=caddy

# Constant variables
_CADDY_TEMPLATE_FILE_SERVER_DEBUG=Caddyfile-file-server-debug

# Computed variables
# PERFECT :) https://www.systutorials.com/how-to-get-a-makefiles-directory-for-including-other-makefiles/
_CADDY_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
_CADDY_TEMPLATES_SOURCE=$(_CADDY_SELF_DIR)/caddy-templates
_CADDY_TEMPLATES_TARGET=$(CADDY_SRC_FSPATH)/_caddy-templates



## caddy print, outputs all variables needed to run caddy
caddy-print:
	@echo
	@echo --- CADDY ---

	@echo Deps:
	@echo CADDY_BIN: 				$(CADDY_BIN) installed caddy at : $(shell which $(CADDY_BIN))
	@echo CADDY_BIN_MKCERT: 		$(CADDY_BIN_MKCERT) installed mkcert at : $(shell which $(CADDY_BIN_MKCERT))
	@echo
	@echo Override variables:
	@echo CADDY_SRC_FSPATH: 			$(CADDY_SRC_FSPATH)
	@echo
	@echo Constant variables:
	@echo _CADDY_TEMPLATE_FILE_SERVER_DEBUG:	$(_CADDY_TEMPLATE_FILE_SERVER_DEBUG)
	@echo - runs a basic file server in debug mode.
	@echo
	@echo Computed variables:
	@echo _CADDY_SELF_DIR:					$(_CADDY_SELF_DIR)
	@echo _CADDY_TEMPLATES_SOURCE: 	$(_CADDY_TEMPLATES_SOURCE)
	@echo _CADDY_TEMPLATES_TARGET: 	$(_CADDY_TEMPLATES_TARGET)
	@echo


## caddy dep installs the caddy and mkcert binary to the go bin
## cand copies the templates up into your templates working directory
# Useful where you want to grab them and customise.
caddy-dep:
	@echo
	@echo installing caddy tool
	go install github.com/caddyserver/caddy/v2/cmd/caddy@latest
	@echo installed gio at : $(shell which $(CADDY_BIN))

	@echo installing caddy templates 
	# copy templates up to working dir/templates
	mkdir -p $(_CADDY_TEMPLATES_TARGET)
	cp -r $(_CADDY_TEMPLATES_SOURCE)/* $(_CADDY_TEMPLATES_TARGET)/
	@echo installed caddy templates  at : $(_CADDY_TEMPLATES_TARGET)

	@echo
	@echo installing mkcert tool
	go install filippo.io/mkcert@latest
	@echo installed mkcert at : $(shell which $(CADDY_BIN_MKCERT))

	$(MAKE) caddy-mkcert
	

	

## caddy mkcert installs the certs for browsers to run localhost
caddy-mkcert:
	@echo
	@echo installing mkcert certs
	cd $(CADDY_SRC_FSPATH) && $(CADDY_BIN_MKCERT) -install
	cd $(CADDY_SRC_FSPATH) && $(CADDY_BIN_MKCERT) localhost
	@echo installed mkcert certs at : $(CADDY_SRC_FSPATH)

## caddy run runs caddy using your Caddyfile
caddy-run:
	cd $(CADDY_SRC_FSPATH) && $(CADDY_BIN) fmt -overwrite
	open https://localhost:8443
	cd $(CADDY_SRC_FSPATH) && $(CADDY_BIN) run -watch


