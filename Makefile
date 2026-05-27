# Frontend to dune.

.PHONY: default build install uninstall test clean

default: build

build:
	dune build

test:
	@dune exec ./src/concrete/tests_concrete.exe
#	uncomment when working on step 2
	@dune exec ./src/abstract/tests_abstract.exe -- --const
#	uncomment when working on step 4
	@dune exec ./src/abstract/tests_abstract.exe -- --interval
#	uncomment when working on step 7
	@dune exec ./src/abstract/tests_abstract.exe -- --product

interpretertest:
	@dune exec ./src/concrete/tests_concrete.exe -- --verbose

consttest:
	@dune exec ./src/abstract/tests_abstract.exe -- --verbose --const

intervaltest:
	@dune exec ./src/abstract/tests_abstract.exe -- --verbose --interval

producttest:
	@dune exec ./src/abstract/tests_abstract.exe -- --verbose --product

pdf:
	@find . -type f -name "*.tig" | sort | while read -r file; do \
		echo "Processing file: $$file"; \
		./src/abstract/tiger_abstract.exe --domain interval --pdf "$$file"; \
	done

install:
	dune install

uninstall:
	dune uninstall

clean:
	dune clean
	rm -f *.pdf
	find . -name '*.tex' -exec rm -f {} +

############################################################################
# If you dont have dune, you can comment the lines above and uncomment     #
# the lines below. It's a temporary not ideal fix. You should install dune.#
# It will only work for the step 1 of the project. You should install dune.#
############################################################################

# OCAMLOPT = ocamlopt
# OCAMLFLAGS = -g -I $(BUILD_DIR)
# OCAMLLIBS = str.cmxa
# BUILD_DIR = _build

# # Shared modules (no main)
# COMMON_MODULES = \
#   src/misc/utils \
#   src/misc/errors \
#   src/ast/ast \
#   src/ast/disamb \
#   src/ast/parser \
#   src/ast/lexer \
#   src/ast/fileparser \
#   src/interpreter/value \
#   src/interpreter/env \
#   src/interpreter/state \
#   src/interpreter/interpreter

# # Executable-specific modules (only one has 'main' each)
# TIGER_MAIN = src/concrete/tiger_concrete
# TESTS_MAIN = src/concrete/tests_concrete

# # All modules to compile
# ALL_MODULES = $(COMMON_MODULES) $(TIGER_MAIN) $(TESTS_MAIN)

# # File name components
# BASE_NAMES = $(notdir $(ALL_MODULES))
# CMX_FILES = $(addprefix $(BUILD_DIR)/, $(addsuffix .cmx, $(BASE_NAMES)))
# CMI_FILES = $(addprefix $(BUILD_DIR)/, $(addsuffix .cmi, $(BASE_NAMES)))

# # Executables
# TIGER_EXE = $(BUILD_DIR)/tiger_concrete.exe
# TESTS_EXE = $(BUILD_DIR)/tests_concrete.exe

# default: build

# build: $(TIGER_EXE) $(TESTS_EXE)

# $(BUILD_DIR):
# 	mkdir -p $(BUILD_DIR)

# # Compile .ml to .cmx and .cmi
# $(BUILD_DIR)/%.cmx: src/misc/%.ml | $(BUILD_DIR)
# 	$(OCAMLOPT) $(OCAMLFLAGS) $(OCAMLLIBS) -c $< -o $@

# $(BUILD_DIR)/%.cmx: src/ast/%.ml | $(BUILD_DIR)
# 	$(OCAMLOPT) $(OCAMLFLAGS) $(OCAMLLIBS) -c $< -o $@

# $(BUILD_DIR)/%.cmx: src/interpreter/%.ml | $(BUILD_DIR)
# 	$(OCAMLOPT) $(OCAMLFLAGS) $(OCAMLLIBS) -c $< -o $@

# $(BUILD_DIR)/%.cmx: src/concrete/%.ml | $(BUILD_DIR)
# 	$(OCAMLOPT) $(OCAMLFLAGS) $(OCAMLLIBS) -c $< -o $@

# # Linking
# $(TIGER_EXE): $(BUILD_DIR) $(CMX_FILES)
# 	$(OCAMLOPT) $(OCAMLFLAGS) $(OCAMLLIBS) $(addprefix $(BUILD_DIR)/, \
# 	$(notdir $(COMMON_MODULES:=.cmx)) tiger_concrete.cmx) -o $@

# $(TESTS_EXE): $(BUILD_DIR) $(CMX_FILES)
# 	$(OCAMLOPT) $(OCAMLFLAGS) $(OCAMLLIBS) $(addprefix $(BUILD_DIR)/, \
# 	$(notdir $(COMMON_MODULES:=.cmx)) tests_concrete.cmx) -o $@

# # Test commands
# test: $(TESTS_EXE)
# 	$(TESTS_EXE)

# interpretertest: $(TESTS_EXE)
# 	$(TESTS_EXE) --verbose

# clean:
# 	rm -rf $(BUILD_DIR)
# 	find . -name '*.cm[iox]' -o -name '*.o' -o -name '*.exe' -o -name '*~' -exec rm -f {} +
