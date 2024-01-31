FILESEXTRAPATHS_prepend := "${THISDIR}/files:"


SPLASH_IMAGES = "file://psplash-electroembedded-img.png;outsuffix=electroembedded"



DEPENDS += "gdk-pixbuf-native"

SRC_URI += "file://psplash-colors.h \
	        file://psplash-bar-img.png \
			file://psplash-electroembedded-img.png"



# The core psplash recipe is only designed to deal with modifications to the
# 'logo' image; we need to change the bar image too, since we are changing
# colors
do_configure_append () {
	cd ${S}
	cp ../psplash-colors.h ./
	# strip the -img suffix from the bar png -- we could just store the
	# file under that suffix-less name, but that would make it confusing
	# for anyone updating the assets
	cp ../psplash-bar-img.png ./psplash-bar.png
	./make-image-header.sh ./psplash-bar.png BAR

	cp ../psplash-electroembedded-img.png  ./psplash-poky.png
	./make-image-header.sh ./psplash-poky.png POKY
	rm -rf psplash-poky.png
	
}


do_hello() {
    echo "####################################################"
    echo "####################################################"
    echo "################# ELECTROEMBEDDED ##################"
    echo "####################################################"
    echo "####################################################"
	cd ${WORKDIR}
	echo "################################################"
	for arg in $(ls | grep '^psplash-.*\-img.h$'); do
		echo "#### Header= ${arg}"
		cp ${S}/psplash-poky-img.h ./${arg}
	done
	echo "################################################"
	rm -rf ${S}/psplash-poky-img.h
}
addtask hello after do_configure before do_compile 


