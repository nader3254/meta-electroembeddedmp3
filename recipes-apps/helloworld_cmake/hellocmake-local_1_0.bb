DESCRIPTION = "hello cmake application" 
SECTION = "examples" 
LICENSE = "CLOSED" 
PR = "r0" 


SRC_URI = "file://*"

S = "${WORKDIR}"

inherit pkgconfig cmake

#
#  do_install() {    
#     install -d ${D}${bindir}
#     install -m 0755 helloworld_cmake ${D}${bindir}
# }