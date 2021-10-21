# https://fly.io/docs/app-guides/run-a-global-image-service/


include ./../../fly.mk
FLY_APP=gedw99-image-service
FLY_ORG=personal

LIB_NAME=image-service

print:

dep:
	# i made this myself

dep-os:
	$(MAKE) fly-dep

console:
	open https://fly.io/apps/$(FLY_APP)

### Global

g-list:
	@echo
	@echo apps
	cd $(LIB_NAME) && $(FLY_BIN) list apps
	@echo
	@echo orgs
	cd $(LIB_NAME) && $(FLY_BIN) list orgs

TEST_FLY_ORG=org-gedw99-test01
g-org-list:
	cd $(LIB_NAME) && $(FLY_BIN) orgs list
g-org-create:
	cd $(LIB_NAME) && $(FLY_BIN) orgs create $(TEST_FLY_ORG)

g-org-delete:
	cd $(LIB_NAME) && $(FLY_BIN) orgs delete $(TEST_FLY_ORG) 

dash:
	# opens the dash
	cd $(LIB_NAME) && $(FLY_BIN) dashboard
dash-metric:
	# opens the metrics
	cd $(LIB_NAME) && $(FLY_BIN) dashboard metrics
dash-billing:
	# they dont seem to have a dedicated command
	# https://fly.io/organizations/personal/usage#gedw99-image-service
	# https://fly.io/organizations/$(FLY_ORG)/usage#$(FLY_APP)
	open https://fly.io/organizations/$(FLY_ORG)/usage#$(FLY_APP)
	#cd $(LIB_NAME) && $(FLY_BIN) info name 

dash-app:
	# opens the actual app.
	cd $(LIB_NAME) && $(FLY_BIN) open

### CREATE or Launch. For this Launch worked and then Deploy..

app-create:
	cd $(LIB_NAME) && $(FLY_BIN) apps create --name $(FLY_APP) --org $(FLY_ORG)
app-create-manual:
	cd $(LIB_NAME) && $(FLY_BIN) apps create
app-list:
	cd $(LIB_NAME) && $(FLY_BIN) apps list
app-delete:
	cd $(LIB_NAME) && $(FLY_BIN) apps destroy $(FLY_APP)
app-suspend:
	cd $(LIB_NAME) && $(FLY_BIN) apps suspend $(FLY_APP)
app-resume:
	cd $(LIB_NAME) && $(FLY_BIN) apps resume $(FLY_APP)

launch:
	#cd $(LIB_NAME) && $(FLY_BIN) launch
	cd $(LIB_NAME) && $(FLY_BIN) launch --name $(FLY_APP) --org personal

deploy:
	# works :)
	cd $(LIB_NAME) && $(FLY_BIN) deploy
	#cd $(LIB_NAME) && $(FLY_BIN) deploy -app $(FLY_APP)

### HISTORY

history:
	# works :)
	cd $(LIB_NAME) && $(FLY_BIN) history

history-logs:
	# runs as a watch, so you can see everything in real time
	cd $(LIB_NAME) && $(FLY_BIN) logs

history-releases:
	cd $(LIB_NAME) && $(FLY_BIN) releases


### VM 
# Used to scale up or down a single VM

vm-list:
	# lists the VM options
	@echo
	@echo -- platform vm --
	cd $(LIB_NAME) && $(FLY_BIN) platform vm-sizes

vm-get-current:
	# https://fly.io/docs/reference/scaling/
	cd $(LIB_NAME) && $(FLY_BIN) scale show

vm-set-shared:
	cd $(LIB_NAME) && $(FLY_BIN) scale vm shared-cpu-1x

	$(MAKE) history-releases 

# CPU OPtions are:
# dedicated-cpu-1x
# dedicated-cpu-2x 
# dedicated-cpu-4x  
# dedicated-cpu-8x 

# RAM Options are:
# 1024
# 4096
vm-set-dedicated:
	cd $(LIB_NAME) && $(FLY_BIN) scale vm dedicated-cpu-1x --memory 4096
	
	$(MAKE) history-releases 

### AUTOSCALE instances ( in same region )
# I use balanced because it moved instances to the regions needed
# TODO try out regions !

autoscale-show:
	# https://fly.io/docs/reference/scaling/
	cd $(LIB_NAME) && $(FLY_BIN) autoscale show

FLY_AUTOSCALE_MIN=1
FLY_AUTOSCALE_MAX=2
autoscale-set-balanced-3-10:
	# https://fly.io/docs/reference/scaling/#modifying-the-autoscaling-plan
	cd $(LIB_NAME) && $(FLY_BIN) autoscale balanced min=3 max=10

	$(MAKE) info

autoscale-set-balanced-1-1:
	# https://fly.io/docs/reference/scaling/#modifying-the-autoscaling-plan
	cd $(LIB_NAME) && $(FLY_BIN) autoscale balanced min=1 max=1

	$(MAKE) info

autoscale-set-none:
	# have to set back to 1-1 first

	# https://github.com/superfly/flyctl/issues/552
	# fly scale count 0

	cd $(LIB_NAME) && $(FLY_BIN) scale count 0

	cd $(LIB_NAME) && $(FLY_BIN) autoscale disable

	$(MAKE) info

info:
	@echo
	@echo -- info --
	cd $(LIB_NAME) && $(FLY_BIN) info
	@echo
	@echo -- status --
	cd $(LIB_NAME) && $(FLY_BIN) status
info-json:
	cd $(LIB_NAME) && $(FLY_BIN) info --json

	
FLY_HOST=gedw99-image-service.fly.dev
##FLY_HOST=localhost:8080
info-gethost:
	cd $(LIB_NAME) && $(FLY_BIN) info --host 

test:
	rm -f ./large.jpg
	curl -O "http://$(FLY_HOST)/crop?width=500&height=400&url=https://raw.githubusercontent.com/h2non/imaginary/master/testdata/large.jpg"
	# see the large.jpg file 


### API
# Can i talk to their NATS or otehr API directly, so that i can whitelabel fly ?
# Can i get detailed billing info
	
