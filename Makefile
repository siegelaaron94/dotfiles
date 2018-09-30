UNAME_S := $(shell uname -s)
DOTFILE_PATH := $(shell pwd)
FILES_IN_GIT := $(patsubst home/%,$(HOME)/%,$(filter home/%,$(shell git ls-files)))

define windows_to_wsl
	$(shell echo "$(1)" | sed 's@\\@/@g' | sed 's@C:/@/mnt/c/@g')
endef

DOTFILES := $(FILES_IN_GIT)
ifneq ($(shell grep Microsoft /proc/version),)
	USERNAME := $(shell cmd.exe /c "echo %USERNAME%")
	LOCALAPPDATA := $(call windows_to_wsl,$(shell cmd.exe /c "echo %LOCALAPPDATA%"))
	DOTFILES += $(HOME)/.minttyrc
	DOTFILES += $(LOCALAPPDATA)/wsltty/home/$(USERNAME)/.minttyrc
else
	DOTFILES += $(HOME)/.atom/installed-packages.txt
endif
	
ifeq ($(UNAME_S),Darwin)
	DOTFILES += $(HOME)/Library/Developer/Xcode/UserData/FontAndColorThemes/Dracula.xccolortheme
endif

all: $(DOTFILES) 

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

$(LOCALAPPDATA)/wsltty/home/$(USERNAME)/.minttyrc: $(HOME)/.minttyrc
	@mkdir -p $(@D)
	@rm -rf $@
	cp $< $@ 

