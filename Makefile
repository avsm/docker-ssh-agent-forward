all:
	./pinata-build-sshd.sh
	@echo Please run "make install"

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

install:
	@if [ ! -d "$(PREFIX)" ]; then echo Error: need a $(PREFIX) directory; exit 1; fi
	@mkdir -p $(BINDIR)
	cp pinata-ssh-forward.sh $(BINDIR)/pinata-ssh-forward
	cp pinata-ssh-mount.sh $(BINDIR)/pinata-ssh-mount

uninstall:
	@if [ ! -d "$(BINDIR)" ]; then echo Error: $(BINDIR) directory does not exist; exit 1; fi
	rm $(BINDIR)/pinata-ssh-forward
	rm $(BINDIR)/pinata-ssh-mount