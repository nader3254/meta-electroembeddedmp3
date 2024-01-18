
<h1>Yocto Project Recipe - CMake Java Application</h1>

<h2>Step-by-Step Explanation</h2>

<h3>1. Description</h3>


<pre>
DESCRIPTION = "hello cmake application"
    </pre>

<p>This line provides a short description of the recipe. In this case, it's a CMake Java application with a simple greeting.</p>

<h3>2. Section</h3>

<pre>
SECTION = "examples"
    </pre>

<p>The 'SECTION' field categorizes the recipe. In this example, the recipe is categorized under "examples".</p>

<h3>3. License</h3>

<pre>
LICENSE = "CLOSED"
    </pre>

<p>The 'LICENSE' field specifies the license type for the recipe. In this case, it's a closed-source application.</p>

<h3>4. PR (Package Revision)</h3>

<pre>
PR = "r0"
    </pre>

<p>The 'PR' field indicates the package revision. It starts at "r0" and increments with each change to the recipe. It helps Yocto Project understand the order of changes.</p>

<h3>5. Source URI</h3>

<pre>
SRC_URI = "file://HelloWorldJava.java"
    </pre>

<p>The 'SRC_URI' field specifies the source URI for the recipe. In this case, it points to the 'HelloWorldJava.java' file in the local filesystem.</p>

<h3>6. Source Directory</h3>

<pre>
S = "${WORKDIR}"
    </pre>

<p>The 'S' variable sets the source directory to the working directory ('${WORKDIR}'). This is where the Yocto Project will find and build the source files.</p>

<h3>7. RDEPENDS</h3>

<pre>
RDEPENDS_${PN} = "java2-runtime"
    </pre>

<p>Specifies runtime dependencies for the package. In this case, it requires the 'java2-runtime'.</p>

<h3>8. Inheritance</h3>

<pre>
inherit java-library
    </pre>

<p>The 'inherit' statement brings in the necessary classes for the recipe. In this case, it inherits from 'java-library' for Java-related functionalities.</p>

<h3>9. Compilation</h3>

<pre>
do_compile() {
    # Compilation of Java files
    # ...
}
    </pre>

<p>The 'do_compile' function compiles Java files using the 'javac' command and creates a JAR file using 'fastjar'.</p>

<h3>10. Installation</h3>

<pre>
do_install() {
    # Installation of compiled Java class
    # ...
}
    </pre>

<p>The 'do_install' function installs the compiled Java class into the package's destination directory.</p>

<h3>11. BBCLASSEXTEND</h3>

<pre>
BBCLASSEXTEND = "native"
    </pre>

<p>Specifies that the class should be extended for native builds.</p>

<p>Feel free to explore and customize this Yocto Project recipe based on your specific needs and requirements.</p>
