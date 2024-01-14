DESCRIPTION = "cameracapture application" 
SECTION = "examples" 
LICENSE = "CLOSED" 


SRC_URI = "file://CMakeLists.txt"

S = "${WORKDIR}"

inherit pkgconfig cmake

do_install() {
    install -d ${D}${bindir}
    install -m 0755 cameracapture ${D}${bindir}
}