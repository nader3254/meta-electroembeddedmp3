SUMMARY = "node.js basic auth parser"
# WARNING: the following LICENSE and LIC_FILES_CHKSUM values are best guesses - it is
# your responsibility to verify that the values are complete and correct.
LICENSE = "CLOSED"

SRC_URI = "file://index.js \
           file://package.json"

# NPM_SHRINKWRAP := "${THISDIR}/${PN}/npm-shrinkwrap.json"
# NPM_LOCKDOWN := "${THISDIR}/${PN}/lockdown.json"

# inherit npm

# Must be set after inherit npm since that itself sets S
S = "${WORKDIR}"

INSTALL_DIR := "/home/root/hello_nodejs"


do_install(){

    install -d ${D}${INSTALL_DIR}
    install -m 0755 ${S}/index.js  ${D}${INSTALL_DIR}
    install -m 0755 ${S}/package.json  ${D}${INSTALL_DIR}
    # install -d ${D}etc
    # install -m 0755 ${S}/resolve.conf  ${D}${INSTALL_DIR}

}

FILES_${PN} += " /home/root/hello_nodejs/index.js \
                /home/root/hello_nodejs/package.json"