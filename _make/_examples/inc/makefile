MAKE_FSPATH=./../../../_make

include $(MAKE_FSPATH)/_inc.mk

print:
	$(MAKE) caddy-print

CADDY_EX_PATH=$(PWD)
this-dep-os:
	$(MAKE) caddy-dep

this-caddy-mkcert:
	$(MAKE) caddy-mkcert

this-caddy-run:
	# runs your caddyfile
	$(MAKE) caddy-run
	open https://localhost

this-caddy-fileserver:
	# runs a fileserver using the file server template.
	$(MAKE) caddy-run-fileserver

