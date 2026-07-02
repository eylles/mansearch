.POSIX:
NAME = mansearch
PREFIX = $(HOME)/.local
BIN_LOC = $(DESTDIR)${PREFIX}/bin
LIB_LOC = $(DESTDIR)${PREFIX}/lib/$(NAME)
DESK_LOC = $(DESTDIR)$(PREFIX)/share/applications
EGPREFIX = $(DESTDIR)$(PREFIX)/share/doc/$(NAME)/examples
.PHONY: install uninstall install-all all

all: $(NAME) $(NAME).desktop

build:
	mkdir build

fzfman: build
	cp fzfman.sh build/$@

configrc: build
	cp configrc.template build/$@

$(NAME): fzfman configrc build
	sed "s|@placeholder@|$(LIB_LOC)|; s|@examples-placeholder@|$(EGPREFIX)|" \
		mansearch.sh > build/$@
	chmod 755 build/$@

$(NAME).desktop: build
	sed "s|@name@|$(NAME)|" \
		mansearch.desktop.in > build/$@

install: $(NAME)
	mkdir -p $(BIN_LOC)
	mkdir -p $(LIB_LOC)
	mkdir -p $(EGPREFIX)
	cp -v $(NAME) $(BIN_LOC)/
	cp -v configrc $(EGPREFIX)/
	cp -v fzfman  $(LIB_LOC)/

install-desktop: $(NAME).desktop
	mkdir -p $(DESK_LOC)
	cp $(NAME).desktop $(DESK_LOC)/
	rm $(NAME).desktop

install-all: install install-desktop

uninstall:
	rm -vf $(BIN_LOC)/$(NAME)
	rm -vf $(LIB_LOC)/fzfman
	rm -rf $(LIB_LOC)
	rm -vf $(DESK_LOC)/$(NAME).desktop
	rm -vf $(EGPREFIX)/configrc
	rm -rf $(EGPREFIX)

clean:
	rm -vrf build
