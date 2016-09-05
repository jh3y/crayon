MODULES = ./node_modules/.bin
STYLUS = $(MODULES)/stylus
BABEL = $(MODULES)/babel
POSTCSS = $(MODULES)/postcss
PUG = $(MODULES)/pug
BS = $(MODULES)/browser-sync

OUTPUT_DIR = public
DEPLOY_DIR = tmp
SRC_BASE = src


MARKUP_FILE = index.pug
DEPLOY_OPTS_FILE = DEPLOY_OPTIONS.js

POSTCSS_OPTS = --use autoprefixer $(OUTPUT_DIR)/style.css -d $(OUTPUT_DIR)

SCRIPT_SRC = $(SRC_BASE)/$(PEN)/$(SCRIPT_FILE)
MARKUP_SRC = $(SRC_BASE)/$(PEN)/$(MARKUP_FILE)
README_SRC = $(SRC_BASE)/$(PEN)/$(README_FILE)
MARKUP_COMPILE_SRC = $(SRC_BASE)/$(PEN)/
MARKUP_DEV_SRC = $(SRC_BASE)/$(PEN)/$(MARKUP_DEV_FILE)
STYLE_SRC  = $(SRC_BASE)/style/style.styl

help:
	@grep -E '^[a-zA-Z\._-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

compile-style: ## compiles styles
	$(STYLUS) src/style/style.styl -o $(OUTPUT_DIR) && $(POSTCSS) $(POSTCSS_OPTS)

watch-style: compile-style ## watches and compiles styles
	$(STYLUS) -w src/style -o $(OUTPUT_DIR)

compile-markup: ## compiles markup
	$(PUG) -P src/markup/index.pug -o $(OUTPUT_DIR)

setup: ## set up project for development
	npm install

watch: ## run development watch
	make watch-style

build: ## build sources
	make compile-style && make compile-markup

serve: build ## sets up browser-sync local static server with livereload
	$(BS) start --port 1987 --files $(OUTPUT_DIR)/ --server $(OUTPUT_DIR)

develop: ## run development task for given PEN "make develop PEN=A"
	make serve & make watch

cleanup: ## tidy out any generated/deployed files
	rm -rf public tmp
	rm $(DEPLOY_OPTS_FILE)

deploy: checkForPen build ## generates POST page for pushing to Codepen
	echo "var SOURCE = {}; SOURCE.MARKUP = \``cat $(MARKUP_DEV_SRC)`\`; SOURCE.STYLE= \``cat $(STYLE_SRC)`\`; exports.SOURCE = SOURCE;" > $(DEPLOY_OPTS_FILE)
	$(PUG) -P deploy-template.pug -O $(DEPLOY_OPTS_FILE) -o tmp
	open tmp/deploy-template.html
