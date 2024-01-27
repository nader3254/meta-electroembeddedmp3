#
# This file was derived from the 'Hello World!' example recipe in the
# Yocto Project Development Manual.
#

SUMMARY = "bitbake-layers recipe"
DESCRIPTION = "Recipe example for cpp application on github"
LICENSE = "CLOSED"

TARGET_CC_ARCH += "${LDFLAGS}"

S = "${WORKDIR}"

SRC_URI = "git://github.com/nader3254/codes_labs.git;protocol=https;branch=main \
            "
SRCREV = "a4a1f21faf869548990d6a3d85f2502f22c9b202"


S = "${WORKDIR}/git"



do_compile() {
         ${CXX} helloworldgit.cpp -o helloworldcpp_git
}

do_install() {
         install -d ${D}${bindir}
         install -m 0755 helloworldcpp_git ${D}${bindir}
}

