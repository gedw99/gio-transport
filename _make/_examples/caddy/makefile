

MAKE_FSPATH=./../../../_make
include $(MAKE_FSPATH)/caddy.mk
include $(MAKE_FSPATH)/go.mk
include $(MAKE_FSPATH)/help.mk

print:
	$(MAKE) caddy-print

CADDY_EX_PATH=$(PWD)
this-dep-os:
	$(MAKE) caddy-dep

this-caddy-run:
	# runs your caddyfile
	$(MAKE) caddy-run
	open https://localhost

this-caddy-fileserver:
	# runs a fileserver using the file server template.
	$(MAKE) caddy-run-fileserver

