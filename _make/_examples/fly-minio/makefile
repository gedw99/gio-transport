# https://fly.io/docs/app-guides/minio/
# https://github.com/fly-apps/appkata-minio/

# Because its docker based, it will first rrun a builder, and then the app. so you see 2 things in the web console.

include ./../../fly.mk
FLY_APP=gedw99-minio
FLY_ORG=personal

LIB_NAME=appkata-minio

print:

dep:
	git clone https://github.com/fly-apps/appkata-minio/

dep-os:
	$(MAKE) fly-dep

create:
	cd $(LIB_NAME) && $(FLY_BIN) apps create $(FLY_APP) --org $(FLY_ORG)
create-delete:
	cd $(LIB_NAME) && $(FLY_BIN) apps destroy $(FLY_APP)

console:
	open https://fly.io/apps/$(FLY_APP)

deploy:
	cd $(LIB_NAME) && $(FLY_BIN) deploy

launch:
	# launc the thing i deployed
	#cd $(LIB_NAME) && $(FLY_BIN) launch
	cd $(LIB_NAME) && $(FLY_BIN) launch $(FLY_APP) --dockerfile --org personal --port 9000

launch-delete:
	cd $(LIB_NAME) && $(FLY_BIN) ??

info:
	cd $(LIB_NAME) && $(FLY_BIN) info
