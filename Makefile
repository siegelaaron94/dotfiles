UNAME_S := $(shell uname -s)
DOTFILE_PATH := $(shell pwd)
FILES_IN_GIT := $(patsubst home/%,$(HOME)/%,$(filter home/%,$(shell git ls-files)))

DOTFILES := $(FILES_IN_GIT)
ifeq ($(UNAME_S),Darwin)
	DOTFILES += $(HOME)/Library/Developer/Xcode/UserData/FontAndColorThemes/Dracula.xccolortheme
else ifeq ($(UNAME_S),Linux)
else
	DOTFILES += $(HOME)/.minttyrc
endif

all: $(DOTFILES) $(HOME)/.atom/installed-packages.txt

$(HOME)/.atom/installed-packages.txt: $(DOTFILE_PATH)/src/atom-packages.txt
	apm install --packages-file $(DOTFILE_PATH)/src/atom-packages.txt
	@mkdir -p $(@D)
	@rm -rf $@
	@touch $(HOME)/.atom/installed-packages.txt

$(HOME)/.minttyrc: $(DOTFILE_PATH)/src/mintty/dracula.minttyrc $(DOTFILE_PATH)/home/.minttyrc
	@mkdir -p $(@D)
	@rm -rf $@
	cat $^ > $@

$(HOME)/Library/Developer/Xcode/UserData/FontAndColorThemes/Dracula.xccolortheme: $(DOTFILE_PATH)/src/xcode/Dracula.xccolortheme 
	@mkdir -p $(@D)
	@rm -rf $@
	ln -s $< $@ 

$(HOME)/%: $(DOTFILE_PATH)/home/%
	@mkdir -p $(@D)
	@rm -rf $@
	ln -s $< $@ 


