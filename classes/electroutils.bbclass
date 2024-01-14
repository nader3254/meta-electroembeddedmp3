
inherit base cmake autotools


FILES_${PN} = ""

python (){
    bb.plain("################ python autonomus #######################")
    bb.plain("################################ setfiles ##############################")
    bb.plain("################################ end of setfiles ##############################")
}


do_hello() {
    echo "####################################################"
    echo "####################################################"
    echo "################# ELECTROEMBEDDED ##################"
    echo "####################################################"
    echo "####################################################"
}

addtask hello after do_configure before do_compile 



do_compile(){
    echo "################ compilecpp ###################"
    cd ${S}
    echo `pwd`
    mkdir -p ${S}/build
    for arg in ${CPP_FILES}; do
        ${CXX} ${arg}  -o "${arg%.cpp}_cpp"
        cp  ${arg%.cpp}_cpp  ${S}/build/${arg%.cpp}_cpp 
    done
}

do_install(){
    COMPILED_FILES=`ls ${S}/build`
    echo "****************** ${COMPILED_FILES} *********************"
    echo "" >> ${S}/files.txt
    echo "################ installing default ###################"
    for arg in ${COMPILED_FILES} ; do
            install -d ${D}${INSTALL_DIR}
            install -m 0755 ${S}/build/${arg}  ${D}${INSTALL_DIR}
            echo "${INSTALL_DIR}/${arg}" >> ${S}/files.txt
    done
}

python do_package_prepend(){
    ss = d.getVar('S',True)
    pv=d.getVar('PN',True)
    fls=d.getVar('FILES_'+pv,True)
    try:
        file_path = ss+'/files.txt'
        with open(file_path, 'r') as file:
            file_content = file.read()
            lines = file_content.split('\n')
            for line in lines:
                if line != "" and line != "default":
                    bb.plain('#### line='+line)
                    if line in fls:
                        bb.plain("skipped this line because it is exist")
                    else:
                        fls += "\n"+line
    except:
        pass
    d.setVar('FILES_'+pv,fls )
}


electroutils_do_exampleexport() {
   
    echo "################################ exporting example ##############################"

} 

EXPORT_FUNCTIONS  do_exampleexport




