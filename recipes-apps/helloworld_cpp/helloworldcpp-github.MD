
<h1>Yocto Project Recipe - Hello World from GitHub</h1>

<p>This Yocto Project recipe is derived from the 'Hello World!' example in the Yocto Project Development Manual.</p>

<h2>Recipe Metadata</h2>

<ul>
        <li><strong>SUMMARY:</strong> bitbake-layers recipe</li>
        <li><strong>DESCRIPTION:</strong> Recipe example for a CPP application on GitHub</li>
        <li><strong>LICENSE:</strong> CLOSED</li>
        <li><strong>TARGET_CC_ARCH:</strong> ${LDFLAGS}</li>
    </ul>

<h2>Source Directory and GitHub Repository</h2>

<pre>
S = "${WORKDIR}"

SRC_URI = "git://github.com/nader3254/codes_labs.git;protocol=https;branch=main"
SRCREV = "a4a1f21faf869548990d6a3d85f2502f22c9b202"

S = "${WORKDIR}/git"
    </pre>

<p>Sets the source directory (S) to the working directory (WORKDIR) and specifies the GitHub repository as the source (SRC_URI). The SRCREV points to a specific commit.</p>

<h2>Compilation Step</h2>

<pre>
do_compile() {
    ${CXX} helloworldgit.cpp -o helloworldcpp_git
}
    </pre>

<p>Compiles the 'helloworldgit.cpp' file from the GitHub repository into an executable named 'helloworldcpp_git' using the C++ compiler (${CXX}).</p>

<h2>Installation Step</h2>

<pre>
do_install() {
    install -d ${D}${bindir}
    install -m 0755 helloworldcpp_git ${D}${bindir}
}
    </pre>

<p>Creates the destination directory and installs the compiled binary 'helloworldcpp_git' with appropriate permissions.</p>
