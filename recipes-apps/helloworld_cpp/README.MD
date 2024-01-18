
<h1>Yocto Project Hello World Recipe</h1>

<p>This Yocto Project recipe provides a simple example for building and installing a C++ application called 'helloworld_cpp'. The recipe is derived from the 'Hello World!' example in the Yocto Project Development Manual.</p>

<h2>Recipe Metadata</h2>

<ul>
    <li><strong>SUMMARY:</strong> bitbake-layers recipe</li>
    <li><strong>DESCRIPTION:</strong> Recipe example for a CPP application onlocal</li>
    <li><strong>LICENSE:</strong> CLOSED</li>
    <li><strong>SRC_URI:</strong> file://helloworld.cpp</li>
</ul>

<h2>Compilation and Linking Flags</h2>

<pre>
TARGET_CC_ARCH += "${LDFLAGS}"
</pre>

<p>This line adds the LDFLAGS to the TARGET_CC_ARCH, incorporating additional compiler flags.</p>

<h2>Source Directory</h2>

<pre>
S = "${WORKDIR}"
</pre>

<p>Sets the source directory (S) to the working directory (WORKDIR).</p>

<h2>Compile Prepend Hook</h2>

<pre>
do_compile_prepend(){
    echo "################## compiling ########################"
}
</pre>

<p>Prints a message before the compilation process starts.</p>

<h2>Compilation Step</h2>

<pre>
do_compile() {
    ${CXX} helloworld.cpp -o helloworld_cpp
}
</pre>

    <p>Compiles the 'helloworld.cpp' file into an executable named 'helloworld_cpp' using the C++ compiler (${CXX}).</p>

<h2>Install Prepend Hook</h2>

<pre>
do_install_prepend(){
    echo "################## installing ########################"
}
</pre>

<p>Prints a message before the installation process starts.</p>

<h2>Installation Step</h2>

<pre>
do_install() {
    install -d ${D}${bindir}
    install -m 0755 helloworld_cpp ${D}${bindir}
}
</pre>

<p>Creates the destination directory and installs the compiled binary 'helloworld_cpp' with appropriate permissions.</p>
