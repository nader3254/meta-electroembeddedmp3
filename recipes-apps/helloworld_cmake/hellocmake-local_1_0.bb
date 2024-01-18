DESCRIPTION = "hello cmake application" 
SECTION = "examples" 
LICENSE = "CLOSED" 
PR = "r0" 


SRC_URI = "file://*"

S = "${WORKDIR}"

inherit pkgconfig cmake
