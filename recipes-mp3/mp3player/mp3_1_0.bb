DESCRIPTION = "hello mp3 application" 
SECTION = "examples" 
LICENSE = "CLOSED" 
PR = "r0" 

DEPENDS += "qtbase qtmultimedia qtquickcontrols2 taglib "
SRC_URI = "file://*"

S = "${WORKDIR}"


MUSIC = ""
MUSICFILES = ""

inherit qmake5




do_install() {

    install -d ${D}/home/root
    install -m 0755 electroembedded_mp3 ${D}/home/root
    # install -d ${D}/home/root/music
    #     MUSIC = `ls ${S}/music`
    #     for arg in ${MUSIC} ; do
    #         install -m 0755 ${S}/music/${arg}  ${D}/home/root/music
    #         MUSICFILES += "${S}/music/${arg} "
    #     done

}

FILES_${PN} += "/home/root/electroembedded_mp3"
