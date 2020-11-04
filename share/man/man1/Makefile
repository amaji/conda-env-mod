# Makefile and helpful discussion on man page generation:
# https://eddieantonio.ca/blog/2015/12/18/authoring-manpages-in-markdown-with-pandoc/

PANDOC ?= pandoc
MANSECTION ?= 1

SRC = conda-env-mod.$(MANSECTION)

.PHONY: all clean

all: ${SRC}

clean:
	rm ${SRC}

%.$(MANSECTION): %.$(MANSECTION).md
	$(PANDOC) --standalone $(PANDOCFLAGS) --to man $< -o $@
