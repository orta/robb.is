BUILD_DIR := _site

refresh:
	@osascript scripts/refresh-browser.scpt

serve:
	@jekyll serve --watch
