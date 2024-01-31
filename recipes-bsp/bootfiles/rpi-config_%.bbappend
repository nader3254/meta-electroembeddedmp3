DESCRIPTION = "Commented config.txt file for the Raspberry Pi. \
               The Raspberry Pi config.txt file is read by the GPU before \
               the ARM core is initialised. It can be used to set various \
               system configuration parameters."

# VC4DTBO = "vc4-kms-v3d"


do_deploy_append() {

    # Disable rainbow splash
    sed -i '/#disable_splash=/ c\disable_splash=1' ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    
    # Set boot delay
    sed -i '/#boot_delay=/ c\boot_delay=0' ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
 
    # VC4 Graphics support
    sed -i '/dtoverlay=${VC4DTBO}/ c\dtoverlay="vc4-kms-v3d"' ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt

    # Enable Audio Device Tree
    echo "# Enable audio (loads snd_bcm2835)" >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    echo "dtparam=audio=on" >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt

}

