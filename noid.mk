DATECODE:=$(shell date -u "+%Y%m%d")

NOID_LIVE_ARCHS:=x86_64
NOID_LIVE_FLAVORS:=xfce gnome kde
NOID_ALL_LIVE_ISO=$(foreach arch,$(NOID_LIVE_ARCHS), $(foreach flavor,$(NOID_LIVE_FLAVORS),noid-live-$(arch)-$(DATECODE)-$(flavor).iso))
NOID_REPOSITORY:=https://github.com/noid-linux/xbps-repo/releases/latest/download
NOID_PACKAGES:=neovim alacritty starship brave ndpm flatpak noid-welcome calamares bazaar git
NOID_XFCE_PACKAGES:=$(NOID_PACKAGES) gruvbox-material-theme gruvbox-bibata-cursor-theme nerd-fonts-cascadiacode blanket

noid-live-iso-all: $(NOID_ALL_LIVE_ISO)

noid-live-iso-all-print:
	@echo $(NOID_ALL_LIVE_ISO) | sed "s: :\n:g"

noid-live-%-xfce.iso: mkiso.sh
	@[ -n "${CI}" ] && printf "::group::\x1b[32mBuilding $@...\x1b[0m\n" || true
	$(SUDO) ./mkiso.sh \
		-r $(REPOSITORY) \
		-r $(NOID_REPOSITORY) \
		-t $*-xfce \
		-- \
		-b noid-base-system \
		-f noid-base-files \
		-o noid-live-$*-xfce.iso \
		-p "$(NOID_XFCE_PACKAGES)" \
		-I ./iso-profiles/common/ \
		-I ./iso-profiles/xfce/ \
		-C "live.autologin" \
		-T "Noid Linux"

	$(SUDO) ./mkiso.sh \
		-r $(REPOSITORY) \
		-r $(NOID_REPOSITORY) \
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
	@[ -n "${CI}" ] && printf '::endgroup::\n' || true


noid-live-%-gnome.iso: mkiso.sh
	@[ -n "${CI}" ] && printf "::group::\x1b[32mBuilding $@...\x1b[0m\n" || true
	$(SUDO) ./mkiso.sh \
		-r $(REPOSITORY) \
		-r $(NOID_REPOSITORY) \
		-t $*-gnome \
		-- \
		-b noid-base-system \
		-f noid-base-files \
		-o noid-live-$*-gnome.iso \
		-p "$(NOID_PACKAGES)" \
		-I ./iso-profiles/common/ \
		-I ./iso-profiles/gnome/ \
		-C "live.autologin" \
		-T "Noid Linux"
	@[ -n "${CI}" ] && printf '::endgroup::\n' || true

noid-live-%-kde.iso: mkiso.sh
	@[ -n "${CI}" ] && printf "::group::\x1b[32mBuilding $@...\x1b[0m\n" || true
	$(SUDO) ./mkiso.sh \
		-r $(REPOSITORY) \
		-r $(NOID_REPOSITORY) \
		-t $*-kde \
		-- \
		-b noid-base-system \
		-f noid-base-files \
		-o noid-live-$*-kde.iso \
		-p "$(NOID_PACKAGES)" \
		-I ./iso-profiles/common/ \
		-I ./iso-profiles/kde/ \
		-C "live.autologin" \
		-T "Noid Linux"
	@[ -n "${CI}" ] && printf '::endgroup::\n' || true
