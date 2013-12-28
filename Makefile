#!/usr/bin/make -f

RUDEL_VERSION := 0.3alpha1
EMACS := /Applications/Emacs.app/Contents/MacOS/Emacs
TAR := gtar

all: compile

compile:
	$(EMACS) -batch -q -no-site-file -eval '(setq compile-rudel-directory t)' -load rudel-compile.el

rudel-loaddefs.el: rudel-compile.el
	$(EMACS) -batch -q -no-site-file -load $<

clean:
	rm -f *.elc rudel-loaddefs.el rudel-*.tar

elpa: rudel-$(RUDEL_VERSION).tar

rudel-$(RUDEL_VERSION).tar: rudel-loaddefs.el
	rm -f $@
	$(TAR) --transform='s::rudel-$(RUDEL_VERSION)/:' -cf $@ \
	    --exclude=./git --exclude=./.gitignore --exclude=./.bzrignore \
	    --exclude ./Makefile --exclude=Project.ede --exclude=./rudel-*.tar \
	    --exclude=*.elc --exclude=*~ \
	    *

.PHONY: all compile clean elpa
