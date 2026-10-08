DATECODE:=$(shell date -u "+%Y%m%d")

NOID_LIVE_ARCHS:=x86_64
NOID_LIVE_INIT_SYSTEMS:=runit dinit
NOID_LIVE_FLAVORS:=xfce gnome kde
NOID_ALL_LIVE_ISO=$(foreach init,$(NOID_LIVE_INIT_SYSTEMS), $(foreach flavor,$(NOID_LIVE_FLAVORS),noid-live-$(NOID_LIVE_ARCHS)-$(DATECODE)-$(flavor)-$(init).iso))
NOID_REPOSITORY:=https://github.com/noid-linux/xbps-repo/releases/latest/download
NOID_PACKAGES:=neovim alacritty starship brave ndpm flatpak noid-welcome calamares bazaar git
NOID_XFCE_PACKAGES:=$(NOID_PACKAGES) gruvbox-material-theme gruvbox-bibata-cursor-theme nerd-fonts-cascadiacode blanket

noid-live-iso-all: $(NOID_ALL_LIVE_ISO)

noid-live-iso-all-print:
	@echo $(NOID_ALL_LIVE_ISO) | sed "s: :\n:g"

noid-live-%-xfce-dinit.iso: mkiso.sh
	$(SUDO) ./mkiso.sh \
		-r $(NOID_REPOSITORY) \
		-r $(REPOSITORY) \
		-t $*-xfce \
		-- \
		-b noid-base-system-dinit \
		-f noid-base-files \
		-o noid-live-$*-xfce-dinit.iso \
		-p "$(NOID_XFCE_PACKAGES) dbus-dinit lightdm-dinit NetworkManager-dinit polkit-dinit openssh-dinit chrony-dinit" \
		-I ./iso-profiles/common/ \
		-I ./iso-profiles/xfce/ \
		-C "live.autologin" \
		-T "Noid Linux"

noid-live-%-xfce-runit.iso: mkiso.sh
	$(SUDO) ./mkiso.sh \
		-r $(NOID_REPOSITORY) \
		-r $(REPOSITORY) \
		-t $*-xfce \
		-- \
		-b noid-base-system \
		-f noid-base-files \
		-o noid-live-$*-xfce-runit.iso \
		-p "$(NOID_XFCE_PACKAGES)" \
		-I ./iso-profiles/common/ \
		-I ./iso-profiles/xfce/ \
		-C "live.autologin" \
		-T "Noid Linux"


noid-live-%-gnome-runit.iso: mkiso.sh
	$(SUDO) ./mkiso.sh \
		-r $(NOID_REPOSITORY) \
		-r $(REPOSITORY) \
		-t $*-gnome \
		-- \
		-b noid-base-system \
		-f noid-base-files \
		-o noid-live-$*-gnome-runit.iso \
		-p "$(NOID_PACKAGES)" \
		-I ./iso-profiles/common/ \
		-I ./iso-profiles/gnome/ \
		-C "live.autologin" \
		-T "Noid Linux"

noid-live-%-kde-runit.iso: mkiso.sh
	$(SUDO) ./mkiso.sh \
		-r $(NOID_REPOSITORY) \
		-r $(REPOSITORY) \
		-t $*-kde \
		-- \
		-b noid-base-system \
		-f noid-base-files \
		-o noid-live-$*-kde-runit.iso \
		-p "$(NOID_PACKAGES)" \
		-I ./iso-profiles/common/ \
		-I ./iso-profiles/kde/ \
		-C "live.autologin" \
		-T "Noid Linux"

noid-live-%-gnome-dinit.iso:
	

noid-live-%-kde-dinit.iso:
	

noid-dist: distdir-$(DATECODE)
	mv noid*$(DATECODE)* distdir-$(DATECODE)/

.PHONY: noid-dist noid-live-iso-all noid-live-iso-all-print
