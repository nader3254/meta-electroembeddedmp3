
<h1>Yocto Project Recipe with Patch</h1>

<p>This Yocto Project recipe is derived from the 'Hello World!' example in the Yocto Project Development Manual. It includes a patch applied to the original 'helloworld.cpp' file using the 'diff' tool.</p>

<h2>Recipe Metadata</h2>

<ul>
        <li><strong>SUMMARY:</strong> bitbake-layers recipe</li>
        <li><strong>DESCRIPTION:</strong> Recipe example for a CPP application on local</li>
        <li><strong>LICENSE:</strong> CLOSED</li>
        <li><strong>SRC_URI:</strong> file://helloworld.cpp <br> file://changeHello.patch</li>
        <li><strong>PR:</strong> r1</li>
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

<h2>Patch Application</h2>

<pre>
do_compile() {
    ${CXX} helloworld.cpp -o helloworld_cpp_patch
}
    </pre>

<p>Compiles the patched 'helloworld.cpp' file into an executable named 'helloworld_cpp_patch' using the C++ compiler (${CXX}).</p>

<h2>Installation Step</h2>

<pre>
do_install() {
    install -d ${D}${bindir}
    install -m 0755 helloworld_cpp_patch ${D}${bindir}
}
    </pre>

<p>Creates the destination directory and installs the compiled binary 'helloworld_cpp_patch' with appropriate permissions.</p>

<h2>Creating and Modifying Patches</h2>

<p>To create a patch, you can use the 'diff' tool as follows:</p>

<pre>
diff -u helloworld.cpp helloworld2.cpp > changeHello.patch
    </pre>

<p>After creating the patch, it should be modified manually to remove the reference to the second file and include paths 'a' and 'b' for clarity.</p>

<p>Example modification:</p>
<p>modify the patch file as remove the second file and add paths a and b</p>

<pre>
--- a/helloworld.cpp	2024-01-11 03:34:59.263121985 +0200
+++ b/helloworld.cpp	2024-01-11 03:34:55.991177984 +0200
    </pre>