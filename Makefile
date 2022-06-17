EXEC_NAME = notor
DATA_FOLDER = $(HOME)/.notor
TARGET = ./bin/debug/notor
RELEASE = ./bin/release/notor
INSTALL = /usr/local/bin

.PHONY: all
all: debug

.PHONY: debug
debug: ./src/**
	@mkdir -p bin/debug/ || true
	@echo "Compiling..."
	@crystal build src/main.cr -o $(TARGET)
	@echo "Successfully compiled!"

.PHONY: clean
clean:
	@$(RM) bin/debug/** bin/release/**
	@echo "Binaries cleaned."

.PHONY: release
release: ./src/**
	@mkdir -p bin/release/ || true
	@echo "Compiling..."
	@crystal build --release src/main.cr -o $(RELEASE)
	@echo "Finished compiling! Run 'sudo make install' to install."

.PHONY: install
install:
	@mv $(RELEASE) $(INSTALL)
	@echo '# This is an autogenerated uninstall script for the terminal app notor.' >> uninstall.sh
	@echo '# You may run this script to uninstall notor.' >> uninstall.sh
	@echo 'INSTALL=$(INSTALL)' >> uninstall.sh
	@echo 'while true; do' >> uninstall.sh
	@echo 'read -p "Do you want to delete the notes and config files too? [y/n]: " yn;' >> uninstall.sh
	@echo 'case $$yn in' >> uninstall.sh
	@echo '[Yy]*) $(RM) -r $(DATA_FOLDER); break;;' >> uninstall.sh
	@echo '[Nn]*) break;;' >> uninstall.sh
	@echo '*) echo "Please enter y(yes) or n(no)!"' >> uninstall.sh
	@echo 'esac' >> uninstall.sh
	@echo 'done' >> uninstall.sh
	@echo '$(RM) $$INSTALL/$(EXEC_NAME) && echo "Successfully uninstalled!"' >> uninstall.sh
	@echo "Successfully installed!"

.PHONY: uninstall
uninstall:
	@sh uninstall.sh
	@$(RM) uninstall.sh
