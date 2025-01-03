.POSIX:
NAME = mansearch
PREFIX = $(HOME)/.local
BIN_LOC = $(DESTDIR)${PREFIX}/bin
LIB_LOC = $(DESTDIR)${PREFIX}/lib/$(NAME)
.PHONY: install uninstall

fzfman:
	cp fzfman.sh fzfman

$(NAME): fzfman
	sed "s|@placeholder@|$(LIB_LOC)|" \
		mansearch.sh > $(NAME)

install: $(NAME)
	chmod 755 $(NAME)
	mkdir -p $(BIN_LOC)
	mkdir -p $(LIB_LOC)
	cp -v $(NAME) $(BIN_LOC)/
	cp -v fzfman  $(LIB_LOC)/
	rm $(NAME)
	rm fzfman

uninstall:
	rm -vf $(BIN_LOC)/$(NAME)
	rm -vf $(LIB_LOC)/fzfman
	rm -rf $(LIB_LOC)

