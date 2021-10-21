# PACK 


PACK_BIN=go-pack-dmg

# Override variables

# Folder that the outputs wil be in.
PACK_SRC_PATH=pack-src

# The folder path that contains all the application assets
PACK_ASSETS_FILEPATH=$(PACK_SRC_PATH)/assets
# The name of the binary file, relative to the assets folder
PACK_BIN_NAME=bin_name
# If set, will package the app in a DMG based on this template
PACK_DMG_TEMPLATE_NAME=?
# The file of the icon to use for the application
PACK_ICON_FILENAME=icon.png
# The bundle identifier (make it your own) (default "com.example.unknown")
PACK_IDENTIFIER_NAME=com.example.unknown
# The user-facing name of the application
PACK_NAME=pack-name
# The folder into which to output the artefacts (default ".")
PACK_OUT_PATH=pack



# Constant variables
_PACK_TEMPLATE_FILE_SERVER_DEBUG=Caddyfile-file-server-debug

# Computed variables
# PERFECT :) https://www.systutorials.com/how-to-get-a-makefiles-directory-for-including-other-makefiles/
_PACK_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
_PACK_TEMPLATES_SOURCE=$(_PACK_SELF_DIR)/pack-templates
_PACK_TEMPLATES_TARGET=$(PACK_SRC_PATH)/_pack-templates

## Outputs all variables needed to run pack
pack-print:
	@echo
	@echo --- Pack DMG ---
	@echo Packages golang apps for Mac Desktop as DMG.

	@echo Deps:
	@echo PACK_BIN: 				$(PACK_BIN) installed pack at : $(shell which $(PACK_BIN))
	
	@echo
	@echo Override variables:
	@echo PACK_SRC_PATH: 			$(PACK_SRC_PATH)
	@echo PACK_ASSETS_FILEPATH: 	$(PACK_ASSETS_FILEPATH)
	@echo PACK_BIN_NAME: 			$(PACK_BIN_NAME)
	@echo PACK_DMG_TEMPLATE_NAME: 	$(PACK_DMG_TEMPLATE_NAME)
	@echo PACK_ICON_FILENAME: 		$(PACK_ICON_FILENAME)
	@echo PACK_IDENTIFIER_NAME: 	$(PACK_IDENTIFIER_NAME)
	@echo PACK_NAME: 				$(PACK_NAME)
	@echo PACK_OUT_PATH: 			$(PACK_OUT_PATH)
	@echo
	@echo Constant variables:
	@echo _PACK_TEMPLATE_FILE_SERVER_DEBUG:	$(_PACK_TEMPLATE_FILE_SERVER_DEBUG)
	@echo - runs a basic file server in debug mode.
	@echo
	@echo Computed variables:
	@echo _PACK_SELF_DIR:					$(_PACK_SELF_DIR)
	@echo _PACK_TEMPLATES_SOURCE: 	$(_PACK_TEMPLATES_SOURCE)
	@echo _PACK_TEMPLATES_TARGET: 	$(_PACK_TEMPLATES_TARGET)
	@echo

## pack dep installs the pack and mkcert binary to the go bin
## cand copies the templates up into your templates working directory
# Useful where you want to grab them and customise.
pack-dep:
	@echo
	@echo installing pack tool
	# TODO make pack a github project..
	#go install github.com/packserver/pack/v2/cmd/pack@latest
	@echo installed gio at : $(shell which $(PACK_BIN))

	@echo installing pack templates 
	# copy templates up to working dir/templates
	mkdir -p $(_PACK_TEMPLATES_TARGET)
	cp -r $(_PACK_TEMPLATES_SOURCE)/* $(_PACK_TEMPLATES_TARGET)/
	@echo installed pack templates  at : $(_PACK_TEMPLATES_TARGET)

	

## Pack using your Packfile
pack-run:
	# TODO: change the main.go to use a config file, its easier.
	cd $(PACK_SRC_PATH) && $(PACK_BIN)\
		-assets $(PACK_ASSETS_FILEPATH)\
		-bin $(PACK_BIN_NAME)\
		-dmg $(PACK_DMG_TEMPLATE_NAME)\
		-icon $(PACK_ICON_FILENAME)\
		-identifier $(PACK_IDENTIFIER_NAME)\
		-identifier $(PACK_IDENTIFIER_NAME)\
		-name $(PACK_NAME)\
		-o $(PACK_OUT_PATH)\
	