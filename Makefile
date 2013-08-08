BUILD_DIR := _site

.PHONY: refresh
refresh:
	@osascript scripts/refresh-browser.scpt

serve:
	@jekyll serve --watch
