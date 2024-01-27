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


# configure our hellopakgconfig to use feature1
# PACKAGECONFIG_append_pn-hellopakgconfig +=" feature1"







# IMAGE_INSTALL_append ="  nodejs nodejs-npm "







IMAGE_INSTALL_append = " gstreamer1.0-plugins-good \
                         gstreamer1.0-plugins-base \
                         gstd"

IMAGE_INSTALL_append = " alsa-utils \
                         alsa-state"
IMAGE_INSTALL_append = " mesa weston-init"

# LICENSE_FLAGS_WHITELIST_append = " commercial  commercial_gstreamer1.0-plugins-ugly commercial_gstreamer1.0-plugins-ugly"



DISTRO_FEATURES_append = " pulseaudio \
                           opengl \
                           nfs \
                           directfb \
                           alsa \
                           gstreamer"

IMAGE_INSTALL_append = " pulseaudio \
                         pulseaudio-module-dbus-protocol \
                         pulseaudio-server \
                         pulseaudio-module-bluetooth-discover \
                         pulseaudio-module-bluetooth-policy \
                         pulseaudio-module-bluez5-device \
                         pulseaudio-module-bluez5-discover \
                         alsa-utils \
                         alsa-plugins"



IMAGE_FEATURES_append =" ssh-server-dropbear \
                         nfs-server"



IMAGE_INSTALL_append = " kernel-modules "
DISTRO_FEATURES_append += " wayland "



IMAGE_INSTALL_append = " taglib mp3 "



IMAGE_INSTALL_append +=" xinput \
                        qtbase-tools \
                        qtwayland \
                        qtbase  \
                        qtdeclarative \
                        qtimageformats \
                        qtmultimedia \
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




















# MACHINE_FEATURES+="features/gpu screen touchscreen"




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
