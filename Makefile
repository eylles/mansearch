.POSIX:
NAME = mansearch
PREFIX = $(HOME)/.local
BIN_LOC = $(DESTDIR)${PREFIX}/bin
LIB_LOC = $(DESTDIR)${PREFIX}/lib/$(NAME)
DESK_LOC = $(DESTDIR)$(PREFIX)/share/applications
.PHONY: install uninstall install-all

fzfman:
	cp fzfman.sh fzfman

$(NAME): fzfman
	sed "s|@placeholder@|$(LIB_LOC)|" \
		mansearch.sh > $(NAME)

$(NAME).desktop:
	sed "s|@name@|$(NAME)|" \
		mansearch.desktop.in > $(NAME).desktop

install: $(NAME)
	chmod 755 $(NAME)
	mkdir -p $(BIN_LOC)
	mkdir -p $(LIB_LOC)
	cp -v $(NAME) $(BIN_LOC)/
	cp -v fzfman  $(LIB_LOC)/
	rm $(NAME)
	rm fzfman

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

