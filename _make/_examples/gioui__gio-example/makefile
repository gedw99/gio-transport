
# upstream https://github.com/gioui/gio-example
# origin fork: https://github.com/gedw99/gio-example

MAKE_FSPATH=./../..
include $(MAKE_FSPATH)/help.mk
include $(MAKE_FSPATH)/git.mk
include $(MAKE_FSPATH)/go.mk
include $(MAKE_FSPATH)/gio.mk
include $(MAKE_FSPATH)/mob.mk
include $(MAKE_FSPATH)/caddy.mk
include $(MAKE_FSPATH)/pgrok.mk
include $(MAKE_FSPATH)/gcloud.mk
include $(MAKE_FSPATH)/env.mk		# Last so that other dont override it

GIT_NAME=gio-example
GIT_ORG=gioui
GIT_SERVER=github.com/$(GIT_ORG)/$(GIT_NAME)
GIT_BRANCH=main

# toggle to work with different branches on the file system.
# use different folders for each branch.
#GIT_WORK_FSPATH=$(PWD)/origin
GIT_WORK_FSPATH=$(PWD)/upstream

GIO_SRC_NAME=component
GIO_SRC_PATH=$(GIT_WORK_FSPATH)/$(GIT_NAME)/$(GIO_SRC_NAME)

CADDY_SRC_PATH=$(PWD)

PGROK_SRC_PATH=$(PWD)



this-print: 
	$(MAKE) git-print
	$(MAKE) go-print
	$(MAKE) gio-print
	$(MAKE) caddy-print
	$(MAKE) pgrok-print

this-dep-origin:
	$(MAKE) git-repo-clone-origin
this-dep-upstream:
	$(MAKE) git-repo-clone-upstream

this-dep-os:
	# install gogio and commander
	$(MAKE) gio-dep


# all below work :)
this-test:
	cd $(GIO_SRC_PATH) && go test -v ./...
this-build:
	$(MAKE) gio-desk-mac-build
this-run: this-build
	$(MAKE) gio-desk-mac-buildrun

this-web-build:
	$(MAKE) gio-web-build
	# cp $(GIO_BUILD_WEB_PATH) 
this-web-run: this-web-build
	$(MAKE) gio-web-run

this-serve:
	$(MAKE) caddy-run
	# https://localhost:8443/giobuild/web/component.web/
	# http://localhost:80/giobuild/web/component.web/

this-pgrok-serve:
	$(MAKE) pgrok-run
