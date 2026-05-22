SAVER      = Bezier
BUNDLE     = $(SAVER).saver
CONTENTS   = $(BUNDLE)/Contents
MACOS_DIR  = $(CONTENTS)/MacOS
RES_DIR    = $(CONTENTS)/Resources
SWIFT_SRC  = BezierScreenSaverView.swift
P5_URL     = https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.7.0/p5.min.js
INSTALL_TO = $(HOME)/Library/Screen\ Savers

.PHONY: all install open clean help

all: $(BUNDLE)

## Compile and assemble the .saver bundle
$(BUNDLE): $(MACOS_DIR)/$(SAVER) $(RES_DIR)/screensaver.html $(RES_DIR)/p5.min.js
	cp Info.plist $(CONTENTS)/Info.plist
	@echo "Built $(BUNDLE)"

$(MACOS_DIR)/$(SAVER): $(SWIFT_SRC) | $(MACOS_DIR)
	swiftc \
		-module-name $(SAVER) \
		-emit-library \
		-framework ScreenSaver \
		-framework WebKit \
		-framework AppKit \
		$(SWIFT_SRC) \
		-o $@

$(RES_DIR)/screensaver.html: screensaver.html | $(RES_DIR)
	cp screensaver.html $@

## Download p5.js so the bundle has no runtime CDN dependency
$(RES_DIR)/p5.min.js: | $(RES_DIR)
	curl -fsSL $(P5_URL) -o $@

$(MACOS_DIR):
	mkdir -p $@

$(RES_DIR):
	mkdir -p $@

## Copy bundle to ~/Library/Screen Savers (macOS discovers it automatically)
install: $(BUNDLE)
	cp -r $(BUNDLE) $(INSTALL_TO)/
	@echo "Installed. Open System Settings → Screen Saver to select Bezier."

## Install then open System Settings to the Screen Saver panel
open: install
	open "x-apple.systempreferences:com.apple.preference.desktopscreeneffect"

clean:
	rm -rf $(BUNDLE)

help:
	@echo "Targets:"
	@echo "  make          — build Bezier.saver"
	@echo "  make install  — build and install to ~/Library/Screen Savers"
	@echo "  make open     — install and open System Settings → Screen Saver"
	@echo "  make clean    — remove build artifacts"
	@echo ""
	@echo "Requirements: macOS 12+, Xcode Command Line Tools (xcode-select --install)"
