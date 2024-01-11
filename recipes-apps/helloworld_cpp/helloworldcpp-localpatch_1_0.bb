#
# This file was derived from the 'Hello World!' example recipe in the
# Yocto Project Development Manual.
#
SUMMARY = "bitbake-layers recipe"
DESCRIPTION = "Recipe example for cpp application on local"
LICENSE = "CLOSED"
SRC_URI = "file://helloworld.cpp \
           file://changeHello.patch \"


TARGET_CC_ARCH += "${LDFLAGS}"

S = "${WORKDIR}"

do_compile() {
         ${CXX} helloworld.cpp -o helloworld_cpp_patch
}

do_install() {
         install -d ${D}${bindir}
         install -m 0755 helloworld_cpp_patch ${D}${bindir}
}