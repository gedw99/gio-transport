
print:

dep:
	go install github.com/go-flutter-desktop/hover@latest


EX_FPATH=$(PWD)/examples

ex-kitchen-run:
	cd $(EX_FPATH)/kitchen && go mod tidy
	cd $(EX_FPATH)/kitchen && go run .


ex-kitchen-pack-clean:
	# deleres all boilerplate.
	cd $(EX_FPATH)/kitchen && rm ./pubspec.yaml
	cd $(EX_FPATH)/kitchen && rm ./pubspec.lock
	cd $(EX_FPATH)/kitchen && rm -rf ./go/

ex-kitchen-pack-init:
	# gets boilerplate in.
	cp ./pubspec.yaml $(EX_FPATH)/kitchen/pubspec.yaml
	cp ./pubspec.lock $(EX_FPATH)/kitchen/pubspec.lock

	cd $(EX_FPATH)/kitchen && hover init

ex-kitchen-pack-init-darwin:
	cd $(EX_FPATH)/kitchen && hover init-packaging darwin-bundle
	cd $(EX_FPATH)/kitchen && hover init-packaging darwin-dmg
	cd $(EX_FPATH)/kitchen && hover init-packaging darwin-pkg

ex-kitchen-pack-build-darwin:
	cd $(EX_FPATH)/kitchen && hover build darwin-bundle
	cd $(EX_FPATH)/kitchen && hover build darwin-dmg
	cd $(EX_FPATH)/kitchen && hover build darwin-pkg

