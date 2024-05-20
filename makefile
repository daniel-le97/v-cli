# Set the virtual environment directory
MODS_DIR = node-nuke-test


# Activate the virtual environment
mkdirs:
	make clean
	mkdir -p $(MODS_DIR)/should-delete
	cd $(MODS_DIR)/should-delete && bun init --yes

run:
	v crun main.v

fmt:
	v fmt . -w

symlink:
	sudo ln -s "$(pwd)/main" /usr/local/bin/mycli

build:
	time v . -prod
	sudo cp cli /usr/local/bin/


concurrency:
	time v conc.v -prod
	sudo cp conc /usr/local/bin/

# Clean up
clean:
	rm -rf $(MODS_DIR)/should-delete

bombardier:
	bombardier -c 125 -n 10000000 http://localhost:8089
