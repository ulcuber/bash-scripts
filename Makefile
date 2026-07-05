.PHONY: status install init

PRODUCT_NAME := $(shell cat /sys/class/dmi/id/product_name 2>/dev/null |\
				tr '[:upper:]' '[:lower:]' |\
				sed 's/ /-/g')
OS=$(shell grep -Po "(?<=^ID=)'?\w+" /etc/os-release | tr -d "'")

SCRIPT_DIR := $(shell pwd)
HARDWARE_DIR := $(SCRIPT_DIR)/hardware/$(PRODUCT_NAME)
OS_DIR := $(SCRIPT_DIR)/os/$(OS)

status:
	@echo "Can install:"
	@echo "$(HARDWARE_DIR)"
	@echo "$(OS_DIR)"
	@echo "Current PATH:"
	@echo "$$PATH" | tr ':' '\n'

install:
	@grep -q "$(OS_DIR)" ~/.bashrc 2>/dev/null || \
		echo 'export PATH="$(HARDWARE_DIR)/bin-override:$(OS_DIR)/bin-override:$$PATH:$(HARDWARE_DIR)/bin:$(OS_DIR)/bin:$(SCRIPT_DIR)/bin"' >> ~/.bashrc
	@grep -q "$(SCRIPT_DIR)/completions.sh" ~/.bashrc 2>/dev/null || \
		echo 'source "$(SCRIPT_DIR)/completions.sh"' >> ~/.bashrc

init:
	mkdir -p "$(OS_DIR)/bin"
	mkdir -p "$(HARDWARE_DIR)/bin"
