
include ./hack/help.mk

UID:=$(shell id -u)
GID:=$(shell id -g)
PWD:=$(shell pwd)

.PHONY: clear-cache
clear-cache:
	rm -rf /tmp/.elm
	rm -rf $(PWD)/elm-stuff

.PHONY: cli
cli: ##@dev provide docker based environment with elm tooling
	docker run -it --rm -v "$(PWD):/code" -w "/code" -v "/tmp/.elm:/tmp/.elm" -e "HOME=/tmp" -u "$(UID):$(GID)" -p 8000:8000 --entrypoint="bash" codesimple/elm:0.19

.PHONY: build
build: ##@build builds js file from elm source files
	docker run -it --rm -v "$(PWD):/code" -w "/code" -v "/tmp/.elm:/tmp/.elm" -e "HOME=/tmp" -u "$(UID):$(GID)" -p 8000:8000 --entrypoint="bash" codesimple/elm:0.19 -c "elm make src/Main.elm --output=dist/build.js --optimize"
