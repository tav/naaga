# Public Domain (-) 2010-2011 The NaagaJS Authors.
# See the NaagaJS UNLICENSE file for details.

# ------------------------------------------------------------------------------
# Some Globals
# ------------------------------------------------------------------------------

coffee_files := $(wildcard src/*.coffee)
js_files := $(subst .coffee,.js,$(coffee_files))
ucd := src/ucd.js

# ------------------------------------------------------------------------------
# Target Declarations
# ------------------------------------------------------------------------------

.PHONY: all clean test nuke ucd

# ------------------------------------------------------------------------------
# Targets
# ------------------------------------------------------------------------------

all: $(js_files) $(ucd)

$(js_files): %.js: %.coffee
	@echo "=> Generating $@"
	@coffee -c $<

clean.files: $(addsuffix .clean, $(js_files))

%.clean:
	+rm -f $*

clean: clean.files

test:
	@vows src/test/*.coffee

nuke: clean
	+rm -f $(ucd)

$(ucd): $(AMPIFY_LOCAL)/share/ucd/UnicodeData.txt
	@echo "=> Generating $(ucd)"
	@makeucd $(AMPIFY_LOCAL)/share/ucd/UnicodeData.txt src/ucd.js

ucd: $(ucd)
