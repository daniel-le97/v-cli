# Set the virtual environment directory
MODS_DIR = test


# Activate the virtual environment
mkdirs:
	make clean
	mkdir -p $(MODS_DIR)
	mkdir -p $(MODS_DIR)/1
	cd $(MODS_DIR)/1 && bun init --yes
	cd ..
	mkdir -p $(MODS_DIR)/2
	cd $(MODS_DIR)/2 && bun init --yes

run:
	v crun main.v

fmt:
	v fmt . -w

symlink:
	sudo ln -s "$(pwd)/main" /usr/local/bin/mycli

build:
	time v . -prod
	sudo mv cli /usr/local/bin/

# Clean up
clean:
	rm -rf $(MODS_DIR)

bombardier:
	bombardier -c 125 -n 10000000 http://localhost:8089
