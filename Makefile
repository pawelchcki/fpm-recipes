RECIPES := $(patsubst recipes/%, %, $(wildcard recipes/*))

# TARGET_HOST := ubuntu1404
TARGET_HOST := ubuntu1204
.PHONY: all force $(RECIPES)

all: $(RECIPES) 
	@

recipes/%: %
	@

$(RECIPES): %: recipes/%/recipe.rb force
	@echo -e '\n'Making $@ for $(TARGET_HOST)
	@vagrant docker-run $(TARGET_HOST) -- fpm-cook package /vagrant/$< ;\
