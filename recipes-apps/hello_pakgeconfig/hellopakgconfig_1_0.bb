SUMMARY = "Hello World package config"
LICENSE = "CLOSED"

SRC_URI = "file://main.py"

S = "${WORKDIR}"

DEPENDS = " python3"

INSTALL_DIR := "/home/root/pkgconfig_example"

PACKAGECONFIG ?= ""
PACKAGECONFIG[feature1] = "enable-feature-1"
PACKAGECONFIG[feature2] = "enable-feature-2"




# take care of this function
def createConfig(file_path,f1,f2):
    if ((f1 == "yes") and (f2 =="yes")):
        with open(file_path, 'w') as file:
            file.write('feature1=True\nfeature2=True')
    elif ((f1 == "yes") and (f2 =="no")):
        with open(file_path, 'w') as file:
            file.write('feature1=True\nfeature2=False')
    elif ((f1 == "no") and (f2 =="tes")):
        with open(file_path, 'w') as file:
            file.write('feature1=False\nfeature2=True')
    else:
        with open(file_path, 'w') as file:
            file.write('feature1=False\nfeature2=False')        



# face the difference
python do_configure(){
   
    f1= bb.utils.contains('PACKAGECONFIG', 'feature1', 'yes', 'no', d)
    f2= bb.utils.contains('PACKAGECONFIG', 'feature2', 'yes', 'no', d)
    f1_value = d.getVarFlags('PACKAGECONFIG').get('feature1')
    ss = d.getVar('S',True)

    # printing values
    bb.plain("####### F1= "+f1+"############## F2= "+f2)
    # just for explanation
    bb.plain("####### F1 Value= " + f1_value + " ##############")
    path=ss+'/config.py'
    createConfig(path,f1,f2)

}

do_install(){

    install -d ${D}${INSTALL_DIR}
    install -m 0755 ${S}/main.py  ${D}${INSTALL_DIR}
    install -m 0755 ${S}/config.py  ${D}${INSTALL_DIR}

}
FILES_${PN} += " /home/root/pkgconfig_example/config.py \
                 /home/root/pkgconfig_example/main.py"
