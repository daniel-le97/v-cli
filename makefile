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
	v crun main.v node

# Clean up
clean:
	rm -rf $(MODS_DIR)
