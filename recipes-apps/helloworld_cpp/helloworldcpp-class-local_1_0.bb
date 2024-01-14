#
# This file was derived from the 'Hello World!' example recipe in the
# Yocto Project Development Manual.
#
SUMMARY = "bitbake-layers recipe"
DESCRIPTION = "Recipe example for cpp application on local"
LICENSE = "CLOSED"
SRC_URI = "file://helloworld4.cpp \
           file://helloworld3.cpp"


PR = "r3"
TARGET_CC_ARCH += "${LDFLAGS}"

S = "${WORKDIR}"

CPP_FILES="helloworld3.cpp helloworld4.cpp" 
INSTALL_DIR = "/home/root"


inherit electroutils





do_install_append() {

    do_exampleexport
}

