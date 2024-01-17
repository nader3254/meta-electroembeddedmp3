SUMMARY = "ElectroEmbedded mp3 simple image."




IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_LINGUAS = " "

LICENSE = "MIT"

inherit core-image

IMAGE_ROOTFS_SIZE ?= "8192"
IMAGE_ROOTFS_EXTRA_SPACE_append = "${@bb.utils.contains("DISTRO_FEATURES", "systemd", " + 4096", "" ,d)}"






IMAGE_FEATURES += " splash "
IMAGE_INSTALL_append = " psplash "

























IMAGE_INSTALL_append = "hellowordcpp-local \
                        helloworldcpp-github \
                        helloworldcpp-localpatch \
                        hellocmake-local \
                        hellojava \
                        helloworldcpp-class-local \
                        helloworld-module \
                        hellopakgconfig \
                        hellonodejs"


IMAGE_INSTALL += " openjre-8 openjdk-8 python3"


# IMAGE_INSTALL_append ="  nodejs nodejs-npm "

#PREFERRED_PROVIDER_virtual/splash = "plymouth"
#IMAGE_INSTALL_append = "dracut plymouth "
#SPLASH = "plymouth"
#PACKAGECONFIG_append_pn-plymouth += "drm"
#PLYMOUTH_THEME = "tribar"


















# LICENSE_FLAGS_WHITELIST_append = " commercial_faad2"
# VIRTUAL-RUNTIME_init_manager = "systemd"
# VIRTUAL-RUNTIME_initscripts = "systemd-compat-units"
# DISTRO_FEATURES_append = " systemd"
# DISTRO_FEATURES_BACKFILL_CONSIDERED += "sysvinit"
# INIT_MANAGER = "systemd"
