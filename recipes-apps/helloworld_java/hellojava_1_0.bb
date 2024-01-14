DESCRIPTION = "hello cmake application" 
SECTION = "examples" 
LICENSE = "CLOSED" 
PR = "r0" 


SRC_URI = "file://HelloWorldJava.java" 

S = "${WORKDIR}"
# FILES_${PN} += "${bindir} /home/root"

RDEPENDS_${PN} = "java2-runtime"

inherit java-library


do_compile() {
    mkdir -p ${S}/build
    javac -d ${S}/build `find . -name "*.java"`
    echo "############################################"
    echo "################## JAVA ####################"
    echo "############################################"
    ls build
    cp  HelloWorldJava.java  ${S}/build/   
    fastjar cf ${JARFILENAME} -C ${S}/build .
}

BBCLASSEXTEND = "native"

do_install() {
    install -d ${D}/${bindir}
    echo "################## inistalling #################"  
    install -m 0755 ${S}/build/HelloWorldJava.class  ${D}/${bindir}
    # mkdir -p ${D}/home/root
    # install -m 0755 ${S}/build/HelloWorldJava.java  ${D}/home/root
}






# do_compile() {
#     echo "############################################"
#     echo "################## JAVA ####################"
#     echo "############################################"
   
#     echo "############################################"
#     # find -name javac
#     mkdir -p ${S}/build
#     cp *.class ${S}/build/hellojava.class
# }
# DEPENDS = "classpath virtual/java-native"

# inherit java


# inherit java    

