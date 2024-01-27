FILESEXTRAPATHS_prepend := "${THISDIR}/files:"


SPLASH_IMAGES = "file://electroembedded_logo.png;outsuffix=default"


DEPENDS += "gdk-pixbuf-native"

SRC_URI += "file://psplash-colors.h \
	        file://psplash-bar-img.png"



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
}
