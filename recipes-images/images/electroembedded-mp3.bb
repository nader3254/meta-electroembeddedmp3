SUMMARY = "ElectroEmbedded mp3 simple image."




IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_LINGUAS = " "

LICENSE = "MIT"

inherit core-image

IMAGE_ROOTFS_SIZE ?= "12000"
IMAGE_ROOTFS_EXTRA_SPACE_append = "${@bb.utils.contains("DISTRO_FEATURES", "systemd", " + 4096", "" ,d)}"




##############################################
################## SPLASH SCREEN #############
##############################################
IMAGE_FEATURES += " splash "
IMAGE_INSTALL_append = " psplash "


##############################################
################### Java Support #############
##############################################
# IMAGE_INSTALL += " openjre-8 openjdk-8"


##############################################
############## Node js support ###############
##############################################
# IMAGE_INSTALL_append ="  nodejs nodejs-npm "




##############################################
################### Python3 Support #############
##############################################
IMAGE_INSTALL += " python3"











IMAGE_INSTALL_append = " gstreamer1.0 \
                         gstreamer1.0-meta-base \
                         gstreamer1.0-plugins-base \
                         gstreamer1.0-plugins-good \
                         gstreamer1.0-plugins-base \
                         gstreamer1.0-plugins-bad \
                         gstreamer1.0-plugins-ugly \
                         gstd"


IMAGE_INSTALL_append = " alsa-utils \
                         alsa-state"


# LICENSE_FLAGS_WHITELIST_append = " commercial  commercial_gstreamer1.0-plugins-ugly commercial_gstreamer1.0-plugins-ugly"



DISTRO_FEATURES_append = " pulseaudio \
                           dbus \
                           systemd \
                           opengl \
                           nfs \
                           directfb \
                           alsa \
                           gstreamer"

IMAGE_INSTALL_append = " pulseaudio \
                         pulseaudio-server \
                         pulseaudio-misc \
                         pulseaudio-module-dbus-protocol \
                         pulseaudio-module-bluetooth-discover \
                         pulseaudio-module-bluetooth-policy \
                         pulseaudio-module-bluez5-device \
                         pulseaudio-module-bluez5-discover \
                         dbus \
                         mesa \
                         alsa-utils \
                         alsa-conf \
                         alsa-lib \
                         alsa-conf-base \
                         alsa-tools \
                         alsa-utils-speakertest \
                         alsa-plugins"


MACHINE_FEATURES += " bluetooth wifi"
CORE_IMAGE_EXTRA_INSTALL = " rsync "
DISTRO_FEATURES_append = " pi-bluetooth \
                          bluez5 \
                          bluetooth \
                          wifi \
                          systemd \
                          linux-firmware-bcm43430 \
                          linux-firmware-brcmfmac43430"

IMAGE_INSTALL_append = " pi-bluetooth \
                         bluez5 \
                         rpio \
                         rpi-gpio \
                         bluez5-testtools \
                         i2c-tools \
                         hostapd \
                         dhcp-server \
                         udev-rules-rpi \
                         bridge-utils \
                         iptables \
                         wpa-supplicant \
                         linux-firmware-ralink \
                         linux-firmware-bcm43430 \
                         linux-firmware-rtl8192ce \
                         linux-firmware-rtl8192cu \
                         linux-firmware-rtl8192su \
                         linux-firmware-rpidistro-bcm43430"



IMAGE_FEATURES_append =" ssh-server-dropbear \
                         nfs-server"




IMAGE_INSTALL_append = " kernel-modules "
# DISTRO_FEATURES_append += " wayland "
# IMAGE_INSTALL_append = " weston-init weston"


IMAGE_INSTALL_append = " taglib iw mp3 udev-rules-rpi "



IMAGE_INSTALL_append +=" xinput \
                        qtbase-tools \
                        qtwayland \
                        qtbase  \
                        qtdeclarative \
                        qtimageformats \
                        qtmultimedia \
                        qtmultimedia-plugins \
                        qtmultimedia-qmlplugins \
                        qtquickcontrols2 \
                        qtquickcontrols \
                        qtbase-plugins \
                        cinematicexperience \
                        liberation-fonts \
                        qtvirtualkeyboard \
                        qtvirtualkeyboard-plugins \
                        xterm \
                        qt5everywheredemo \
                        qt5-opengles2-test \
                        quitindicators"






####################################################
##################### Custom Apps ##################
####################################################
# IMAGE_INSTALL_append = " hellowordcpp-local \
#                          helloworldcpp-github \
#                          helloworldcpp-localpatch \
#                          helloworldcpp-class-local \
#                          hellocmake-local \
#                          hellojava \
#                          hellopakgconfig \
#                          helloworld-module"
































#PREFERRED_PROVIDER_virtual/psplash = "plymouth"
#IMAGE_INSTALL_append = " plymouth "
#SPLASH = "plymouth"
#PLYMOUTH_THEME = "tribar"



















# LICENSE_FLAGS_WHITELIST_append = " commercial_faad2"
# VIRTUAL-RUNTIME_init_manager = "systemd"
# VIRTUAL-RUNTIME_initscripts = "systemd-compat-units"
# DISTRO_FEATURES_append = " systemd"
# DISTRO_FEATURES_BACKFILL_CONSIDERED += "sysvinit"
# INIT_MANAGER = "systemd"
