PWD=$(shell pwd)
PORT := 8080
IMAGE_NAME := basic_linguistic_indicators
VERSION := latest
REGION := fr-par
REGISTRY_ENDPOINT := rg.$(REGION).scw.cloud
REGISTRY_NAMESPACE := osp-internal-tools
REGISTRY_TAG := $(REGISTRY_ENDPOINT)/$(REGISTRY_NAMESPACE)/$(IMAGE_NAME):$(VERSION)

build:
	docker build -t $(IMAGE_NAME) . --compress

start:
	@make build
	docker run --rm -p $(PORT):$(PORT) -v ${PWD}/dist:/basic_linguistic_indicators/dist $(IMAGE_NAME)
#	docker cp easy-wordclouds:/dist/wordcloud.png $(PWD)/dist/wordcloud.png
#	docker stop easy-wordclouds

test:
	pytest $(find **/*.py) --cov=. --cov-fail-under=90 --cov-report term-missing

lint:
	pylint ./**/*.py

dep:
	pip install pylint
	pip install -r requirements.txt

dep3:
	pip3 install pylint
	pip3 install -r requirements.txt