# GIO

#SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

# TODO: 
# Start using Bingo: https://github.com/owncloud/ocis/tree/master/.bingo, so that versions of binary's are controlled by go-mod on a per project basis.

# TODO: Fyne has packaging we can use: https://github.com/fyne-io/fyne/tree/master/cmd/fyne/internal/commands


# Deps
GIO_BIN=gogio
GIO_WEB_SERVER_BIN=file-server
GIO_COMPILE_DAEMON=compile-daemon

# Override variables
GIO_SRC_NAME=?
GIO_SRC_FSPATH=?FILEPATH?/$(GIO_SRC_NAME)

# Constant variables
GIO_BUILD_FSNAME=giobuild

_GIO_TEMPLATE_FILE_SERVER_DEBUG=Caddyfile-file-server-debug

# Computed variables
GIO_BUILD_FSPATH=$(GIO_SRC_FSPATH)/giobuild
GIO_BUILD_WEB_PATH=$(GIO_BUILD_FSPATH)/web/$(GIO_SRC_NAME).web
GIO_BUILD_WINDOWS_PATH=$(GIO_BUILD_FSPATH)/windows/$(GIO_SRC_NAME).exe
GIO_BUILD_DARWIN_PATH=$(GIO_BUILD_FSPATH)/mac/$(GIO_SRC_NAME).app/Contents/MacOS/$(GIO_SRC_NAME)

_GIO_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
_GIO_TEMPLATES_SOURCE=$(_GIO_SELF_DIR)/gio-templates
_GIO_TEMPLATES_TARGET=$(CADDY_SRC_FSPATH)/_gio-templates

## Prints the variables used.
gio-print:
	@echo
	@echo --- GIO ---
	@echo Deps:
	@echo GIO_BIN: 					$(GIO_BIN) installed gio at : $(shell which $(GIO_BIN))
	@echo GIO_WEB_SERVER_BIN: 		$(GIO_WEB_SERVER_BIN) installed web runner at : $(shell which $(GIO_WEB_SERVER_BIN))
	@echo GIO_COMPILE_DAEMON: 		$(GIO_COMPILE_DAEMON) installed compile-daemon at : $(shell which $(GIO_COMPILE_DAEMON))
	@echo
	@echo Override variables:
	@echo GIO_SRC_FSPATH: 			$(GIO_SRC_FSPATH)
	@echo GIO_SRC_NAME: 			$(GIO_SRC_NAME)
	@echo
	@echo Constant variables:
	@echo GIO_BUILD_FSNAME: 		$(GIO_BUILD_FSNAME)
	@echo _GIO_TEMPLATE_FILE_SERVER_DEBUG:	$(_GIO_TEMPLATE_FILE_SERVER_DEBUG)
	@echo - runs a basic darwin app
	@echo
	@echo Computed variables:
	@echo GIO_BUILD_FSPATH: 		$(GIO_BUILD_FSPATH)
	@echo GIO_BUILD_WEB_PATH: 		$(GIO_BUILD_WEB_PATH)
	@echo GIO_BUILD_WINDOWS_PATH: 	$(GIO_BUILD_WINDOWS_PATH)
	@echo GIO_BUILD_DARWIN_PATH: 	$(GIO_BUILD_DARWIN_PATH)
	@echo
	@echo _GIO_SELF_DIR:					$(_GIO_SELF_DIR)
	@echo _GIO_TEMPLATES_SOURCE: 	$(_GIO_TEMPLATES_SOURCE)
	@echo _GIO_TEMPLATES_TARGET: 	$(_GIO_TEMPLATES_TARGET)
	@echo

## Installs all tools
gio-dep:
	@echo
	@echo -- Installing gogio tool
	# https://git.sr.ht/~eliasnaur/gio
	go install gioui.org/cmd/gogio@latest
	@echo installed gio at : $(shell which $(GIO_BIN))

	@echo installing gio templates 
	# copy templates up to working dir/templates
	mkdir -p $(_GIO_TEMPLATES_TARGET)
	cp -r $(_GIO_TEMPLATES_SOURCE)/* $(_GIO_TEMPLATES_TARGET)/
	@echo installed caddy templates  at : $(_GIO_TEMPLATES_TARGET)


	# FileServer
	#@echo
	#@echo -- Installing FileServer
	#@echo $(PWD)
	#cd tools/file-server && go install .
	#@echo installed FileServer at : $(shell which $(GIO_COMPILE_DAEMON))
	
	# CompileDaemon
	#@echo
	#@echo -- Installing CompileDaemon
	#go install github.com/githubnemo/CompileDaemon@latest
	#@echo installed CompileDaemon at : $(shell which $(GIO_COMPILE_DAEMON))

## Runs the code for Desktop
gio-run:
	# NOTE: Useful for Dev env
	cd $(GIO_SRC_FSPATH) && go run .

## Builds the code for Web and Desktop as a convenience
gio-build:
	cd $(GIO_SRC_FSPATH) && go generate ./...

	# Always do Web
	$(MAKE) gio-web-build

	# TODO Switch based on platform
	$(MAKE) gio-desk-mac-build

# Deletes the gio buidl foolder
gio-build-delete:
	rm -rf $(GIO_BUILD_FSPATH)


### WEB

## Compiles the Web Platform
gio-web-build:
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -o $(GIO_BUILD_WEB_PATH) -target js .

## Depreciated. Use Caddy instead
gio-web-run:
	@echo "Deprecated. Use Caddy Instead"
	exit 1
	#cd $(GIO_SRC_FSPATH) && go generate ./...
	cd $(GIO_SRC_FSPATH)/$(GIO_BUILD_WEB_PATH) ?

## Depreciated
gio-web-watch:
	$(GIO_COMPILE_DAEMON) -color -build="$(MAKE) gio-web-build" -command="$(MAKE) gio-web-run"

	
### DESK

### DESK - MACOS

GIO_PACK_DARWIN_FSPATH=$(GIO_BUILD_FSNAME)/mac/$(GIO_SRC_NAME)
GIO_PACK_DARWIN_NAME=$(GIO_BUILD_FSNAME)/mac/$(GIO_SRC_NAME).app

# NOT finished
gio-desk-mac-pack:
	#go get github.com/JackMordaunt/gopack
	go install git.sr.ht/~jackmordaunt/gopack/cmd/pack@latest
	which pack

gio-desk-mac-pack-init:

	# TODO: Needs mac sign & bundle creation including plist, icons
	# //go:generate mkdir -p example.app/Contents/MacOS
	# //go:generate go build -o example.app/Contents/MacOS/example
	# //go:generate codesign -s - example.app
	# TODO: Samue for Windows

	cd $(GIO_SRC_FSPATH) && mkdir -p $(GIO_PACK_DARWIN_FSPATH).app/Contents/MacOS
	cd $(GIO_SRC_FSPATH) && mkdir -p $(GIO_PACK_DARWIN_FSPATH).app/Contents/MacOS/$(GIO_SRC_NAME)
	cd $(GIO_SRC_FSPATH) && mkdir -p $(GIO_PACK_DARWIN_FSPATH).app/Contents/MacOS/$(GIO_SRC_NAME)

gio-desk-mac-build: 
	cd $(GIO_SRC_FSPATH) && go generate .
	cd $(GIO_SRC_FSPATH) && go build -o $(GIO_BUILD_DARWIN_PATH) .
gio-desk-mac-buildrun:
	cd $(GIO_SRC_FSPATH) && $(GIO_BUILD_DARWIN_PATH)
gio-desk-mac-runpacked:
	cd $(GIO_SRC_FSPATH) && open $(GIO_PACK_DARWIN_NAME)
gio-desk-mac-watch:
	$(GIO_COMPILE_DAEMON) -color -build="$(MAKE) gio-desk-mac-build" -command="$(MAKE) gio-desk-mac-runbuild"
	

### DESK - WINDOWS

# NOT finished
gio-windows-pack-init:
	# TODO: needs to do what gio-desk-mac-pack-init does
gio-windows-build:
	# BUG: component_windows_amd64.syso does not respect the -o path.
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -o $(GIO_BUILD_WINDOWS_PATH) -target windows .
gio-windows-runbuild:
	cd $(GIO_SRC_FSPATH) && $(GIO_BUILD_WINDOWS_PATH)
gio-windows-watch:
	$(GIO_COMPILE_DAEMON) -color -build="$(MAKE) gio-windows-build" -command="$(MAKE) gio-windows-runbuild"
	

### IOS

#IOS_BUILD_PATH=$(GIO_BUILD_FSNAME)/ios/$(GIO_SRC_NAME).ipa

IOS_BUILD_PATH=$(GIO_SRC_NAME).ipa
gio-ios-print:
	@echo IOS_BUILD_PATH: $(IOS_BUILD_PATH)
gio-ios-build:
	# nope - needs a provioning profile.
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -work -appid gedw99.$(GIO_SRC_NAME) -buildmode exe -o $(IOS_BUILD_PATH) -target ios .
gio-ios-install:
	# see: https://www.systutorials.com/docs/linux/man/1-ideviceinstaller/
	# idevice_id -l
	cd $(GIO_SRC_FSPATH) && ideviceinstaller -i $(IOS_BUILD_PATH) --udid bdf90dc799709a013a25d0fc2df80e441df026f3

# Cant use due to a build bug with gogio not respecting the -o path.
#IOS_SIM_BUILD_PATH=$(GIO_BUILD_FSNAME)/ios/$(GIO_SRC_NAME).app
IOS_SIM_BUILD_PATH=$(GIO_SRC_NAME).app

gio-ios-sim-print:
	@echo IOS_SIM_BUILD_PATH: $(IOS_SIM_BUILD_PATH)
gio-ios-sim-build:
	#exe and archive
	# -work IF you want to see the xcode generated.
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -work -appid gedw99.$(GIO_SRC_NAME) -buildmode exe -o $(IOS_SIM_BUILD_PATH) -target ios .
gio-ios-sim-install:
	cd $(GIO_SRC_FSPATH) && xcrun simctl install booted $(IOS_SIM_BUILD_PATH)



### AND

gio-and-build:
	cd $(GIO_SRC_FSPATH) && $(GIO_BIN) -o $(GIO_SRC_NAME).apk -target android .
gio-and-install:
	cd $(GIO_SRC_FSPATH) && adb install $(GIO_SRC_NAME).apk