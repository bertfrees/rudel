all:

%.elc: %.el
	emacs -batch -q -no-site-file $(EMACS_PRELOAD) -eval '(byte-compile-file "$<")'

rudel-loaddefs.el: rudel-compile.el
	emacs -batch -q -no-site-file -load $<

all: rudel-loaddefs.el

rudel_obj = rudel-backend.elc rudel-chat.elc rudel-color.elc		\
 rudel-compat.elc rudel-display.elc rudel.elc rudel-errors.elc		\
 rudel-hooks.elc rudel-interactive.elc rudel-mode.elc			\
 rudel-operations.elc rudel-operators.elc rudel-overlay.elc		\
 rudel-protocol.elc rudel-session-initiation.elc rudel-speedbar.elc	\
 rudel-state-machine.elc rudel-transport.elc rudel-transport-util.elc	\
 rudel-util.elc rudel-xml.elc

# These are marked no-byte-compile:
#   rudel-compile.el
#   rudel-debug.el
# These are not intended to be compiled, just loaded
#   rudel-icons.elc

all: $(rudel_obj)

$(rudel_obj): EMACS_PRELOAD=-eval '(setq load-path (cons "." load-path))'

clean:
	-rm -f $(rudel_obj) rudel-loaddefs.el

.PHONY: all clean

