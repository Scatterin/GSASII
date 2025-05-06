# Variables
PYTHON      := python3.13
BUILD_DIR   := dist
REPO        := origin
BRANCH      := main
BINARY_DIR  := binaries
PLATFORM    := Linux-x86_64
BINARY_URL  := https://github.com/AdvancedPhotonSource/GSAS-II-buildtools/releases/latest/download/gsas2main-Latest-$(PLATFORM).sh

.PHONY: all pull deps build wheel clean update-binaries

all: pull deps build

# 1. Pull latest source
pull:
	git fetch $(REPO)
	git checkout $(BRANCH)
	git pull $(REPO) $(BRANCH)

# 2. Install/update build tools
deps:
	$(PYTHON) -m pip install --upgrade build wheel setuptools setuptools_scm

# 3. Build sdist & wheel
build: clean
	$(PYTHON) -m build

# Alias for wheel only
wheel:
	$(PYTHON) -m build --wheel

# Remove previous builds
clean:
	rm -rf $(BUILD_DIR) $(BINARY_DIR)

# 4. Download latest GSAS-II binaries installer
update-binaries:
	mkdir -p $(BINARY_DIR)
	curl -L $(BINARY_URL) -o $(BINARY_DIR)/gsas2main-Latest-$(PLATFORM).sh
	chmod +x $(BINARY_DIR)/gsas2main-Latest-$(PLATFORM).sh
