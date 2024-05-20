# Set the virtual environment directory
MODS_DIR = node-nuke-test

ARGS = $(filter-out $@,$(MAKECMDGOALS))
# Activate the virtual environment
mkdirs:
	make clean
	mkdir -p $(MODS_DIR)/should-delete
	cd $(MODS_DIR)/should-delete && bun init --yes

fmt:
	v fmt . -w

symlink:
	sudo ln -s "$(pwd)/main" /usr/local/bin/mycli

build:
	time v . -prod
	sudo cp cli /usr/local/bin/

run:
	v crun . $(ARGS)

# Clean up
clean:
	rm -rf $(MODS_DIR)/should-delete

bombardier:
	bombardier -c 125 -n 10000000 http://localhost:8089

# Prevent make from trying to use these as file targets
%:
	@:
