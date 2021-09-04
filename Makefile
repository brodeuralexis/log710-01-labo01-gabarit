# Structure du projet
SOURCE_DIR         := src
HEADER_DIR         := src
TARGET_DIR         := target

# Définition de variables qui seront réutilisées plus tard.
CC                 ?= gcc
CPPFLAGS           += $(shell pkg-config --cflags readline)
CFLAGS             += -Wall -Wextra -Werror=vla -Werror=alloca -Werror=main -std=gnu11 -ggdb
LDFLAGS            += $(shell pkg-config --libs readline)

# Utilitaires
rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

# Fichiers
log710shell_source_files := $(filter-out $(SOURCE_DIR)/RunCmd.c, $(call rwildcard, $(SOURCE_DIR), *.c))
runcmd_source_files := $(filter-out $(SOURCE_DIR)/Log710Shell.c, $(call rwildcard, $(SOURCE_DIR), *.c))
log710shell_object_files := $(log710shell_source_files:%.c=$(TARGET_DIR)/%.o)
runcmd_object_files := $(runcmd_source_files:%.c=$(TARGET_DIR)/%.o)
dependencies := $(call rwildcard, $(TARGET_DIR), *.d)

# En utilisant:
#
#     $ make clean all PEDANTIC=1
#
# D'autres avertissements seront activés dans GCC.
ifdef PEDANTIC
CFLAGS             += -Wpedantic
endif

# En utilisant:
#
#     $ make clean all IMPORTANT=1
#
# Certains avertissements seront convertit en erreurs, ce qui peut vous aider à
# trouver des problèmes dans votre code.
ifdef IMPORTANT
CFLAGS             += -Werror=uninitialized -Werror=format \
                      -Werror=implicit-function-declaration -Werror=format-overflow \
					  -Werror=misleading-indentation -Werror=return-type \
					  -Werror=maybe-uninitialized -Werror=conversion \
					  -Werror=sign-compare -Werror=address
endif

# Ne pas utiliser si vous ne savez pas ce que vous faites.
#
#     $ make clean all ASAN=1
#
# Active les outils *asan*, et *ubsan* de Google:
#     https://github.com/google/sanitizers
ifdef ASAN
CFLAGS             += -fsanitize=address -fsanitize=undefined
endif

# Ne pas utiliser si vous ne savez pas ce que vous faites.
#
#     $ make clean all LEAKSAN=1
#
# Active l'outil *leaksan* de Google:
#     https://github.com/google/sanitizers
ifdef LEAKSAN
LDFLAGS            += -fsanitize=leak
endif

# La première règle apparaissant dans le GNUMakefile est la règle par défaut
# lorsque le programme `make` est appelé sans arguments.
.PHONY: all
all: RunCmd Log710Shell

# Une règle pour nétoyer le projet et supprimer les exécutables générés.
#
# Il est possible de faire une recompilation de tous les artéfacts avec la
# commande suivante:
#
#     $ make clean all
.PHONY: clean
.SILENT: clean
clean:
	rm -f RunCmd
	rm -f Log710Shell
	rm -rf $(TARGET_DIR)

# Indique comment compiler tous les fichiers .c en fichiers objects.
$(TARGET_DIR)/$(SOURCE_DIR)/%.o: $(SOURCE_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -MMD -MP -c -o $@ $<

# Indique comment construire la commande `RunCmd`.
RunCmd: $(runcmd_object_files)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# Indique comment construire la commande `Log710Shell`.
Log710Shell: $(log710shell_object_files)
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# Avec les options -MMD et -MP de GCC, nous générons des fichiers Makefile à
# côté des fichiers .o contenant l'information des entêtes utilisées par les
# fichier .c équivalent.
#
# Cette information est réutilisée et mise-à-jour à chaque compilation du code
# afin de déterminer les dépendances directes et transitives des entêtes.
#
# La ligne commence par un `-` pour indiquer à Make d'ignorer les erreurs.  Si
# ces fichiers n'existes pas, c'est que nous compilons pour la première fois.
-include $(dependencies)
