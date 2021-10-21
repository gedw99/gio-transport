# https://github.com/gioui/gio-example

LIB_NAME=hello

all: print

MAKE_FSPATH=./../../../_make
include $(MAKE_FSPATH)/help.mk
include $(MAKE_FSPATH)/go.mk
include $(MAKE_FSPATH)/gio.mk
include $(MAKE_FSPATH)/caddy.mk
include $(MAKE_FSPATH)/fly.mk

include ./../pack-dmg.mk


GO_SRC_NAME=$(LIB_NAME)
GO_SRC_FSPATH=$(PWD)/$(GO_SRC_NAME)

GIO_SRC_NAME=$(LIB_NAME)
GIO_SRC_PATH=$(PWD)/$(GIO_SRC_NAME)

CADDY_SRC_PATH=$(PWD)

PACK_SRC_PATH=$(PWD)
#PACK_ASSETS_FILEPATH=$(PWD)/$(LIB_NAME)/assets
PACK_BIN_NAME=hello
PACK_DMG_TEMPLATE_NAME=?
PACK_ICON_FILENAME=?
PACK_IDENTIFIER_NAME=?
PACK_NAME=$(LIB_NAME)
PACK_OUT_PATH=$(PWD)/$(LIB_NAME)/packed

print:
	$(MAKE) go-print
	$(MAKE) gio-print
	$(MAKE) caddy-print
	$(MAKE) pack-print

dep-os:
	$(MAKE) go-dep
	$(MAKE) gio-dep
	$(MAKE) caddy-dep
	$(MAKE) pack-dep

mod-update:
	$(MAKE) go-mod-update
mod-tidy:
	cd $(LIB_NAME) && go mod tidy

build-web:
	$(MAKE) gio-web-build
build-desk:
	$(MAKE) gio-desk-mac-build
	open $(GIO_BUILD_FSPATH) 

serve:
	$(MAKE) caddy-run

pack-desk:
	$(MAKE) pack-run

deploy:
	fly-