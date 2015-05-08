RECIPES := $(patsubst recipes/%, %, $(wildcard recipes/*))

# TARGET := ubuntu1404
TARGET ?= ubuntu1204
.PHONY: all force $(RECIPES)

all: $(RECIPES) 
	@

recipes/%: %
	@

$(RECIPES): %: recipes/%/recipe.rb force
	@echo -e '\n'Making $@ for $(TARGET_)
	@vagrant docker-run $(TARGET) -- fpm-cook package /vagrant/$< ;\
