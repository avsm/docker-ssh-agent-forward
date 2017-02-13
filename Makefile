all:
	./pinata-ssh-pull.sh
	@echo Please run "make install"

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

install:
	@if [ ! -d "$(PREFIX)" ]; then echo Error: need a $(PREFIX) directory; exit 1; fi
	@mkdir -p $(PREFIX)/share/pinata-ssh-agent
	cp ssh-forward-agent.sh $(PREFIX)/share/pinata-ssh-agent/ssh-forward-agent.sh
	@mkdir -p $(BINDIR)
	cp pinata-build-sshd.sh $(BINDIR)/pinata-build-sshd
	cp pinata-ssh-forward.sh $(BINDIR)/pinata-ssh-forward
	cp pinata-ssh-mount.sh $(BINDIR)/pinata-ssh-mount
