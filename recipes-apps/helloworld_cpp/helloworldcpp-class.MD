<h1>Yocto Project Recipe - Hello World Example</h1>

<p>This Yocto Project recipe is derived from the 'Hello World!' example in the Yocto Project Development Manual.</p>

<h2>Recipe Metadata</h2>

<ul>
        <li><strong>SUMMARY:</strong> bitbake-layers recipe</li>
        <li><strong>DESCRIPTION:</strong> Recipe example for a CPP application on local</li>
        <li><strong>LICENSE:</strong> CLOSED</li>
        <li><strong>SRC_URI:</strong> file://helloworld4.cpp <br> file://helloworld3.cpp</li>
        <li><strong>PR:</strong> r3</li>
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

<h2>Additional Configuration</h2>

<pre>
CPP_FILES="helloworld3.cpp helloworld4.cpp" 
INSTALL_DIR = "/home/root"
    </pre>

<p>Defines additional configuration parameters, such as a list of CPP files (CPP_FILES) and the installation directory (INSTALL_DIR).</p>

<h2>Inheritance</h2>

<pre>
inherit electroutils
    </pre>

<p>Uses the 'electroutils' class for inheritance, extending the functionality of the recipe.</p>

<h2>Install Append Hook</h2>

<pre>
do_install_append() {
    do_exampleexport
}
    </pre>

<p>Appends the 'do_exampleexport' task to the installation process.</p>
