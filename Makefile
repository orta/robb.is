BUILD_DIR := _site

.PHONY: refresh build
default: build refresh

build:
	@export LANG=en_US.UTF-8; jekyll build

refresh:
	@osascript scripts/refresh-browser.scpt

serve:
	@jekyll serve
