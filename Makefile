.POSIX:
NAME = mansearch
PREFIX = $(HOME)/.local
BIN_LOC = $(DESTDIR)${PREFIX}/bin
LIB_LOC = $(DESTDIR)${PREFIX}/lib/$(NAME)
DESK_LOC = $(DESTDIR)$(PREFIX)/share/applications
EGPREFIX = $(DESTDIR)$(PREFIX)/share/doc/$(NAME)/examples
.PHONY: install uninstall install-all all

all: $(NAME) $(NAME).desktop

fzfman:
	cp fzfman.sh fzfman

configrc:
	cp configrc.template configrc

$(NAME): fzfman configrc
	sed "s|@placeholder@|$(LIB_LOC)|; s|@examples-placeholder@|$(EGPREFIX)|" \
		mansearch.sh > $(NAME)

$(NAME).desktop:
	sed "s|@name@|$(NAME)|" \
		mansearch.desktop.in > $(NAME).desktop

install: $(NAME)
	chmod 755 $(NAME)
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
	rm -vf $(NAME) $(NAME).desktop fzfman configrc
