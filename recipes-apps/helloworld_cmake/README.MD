<h1>Yocto Project Recipe - CMake Hello Application</h1>

<h2>Step-by-Step Explanation</h2>

<h3>1. Description</h3>

<pre>
DESCRIPTION = "hello cmake application"
    </pre>

<p>This line provides a short description of the recipe. In this case, it's a CMake application with a simple greeting.</p>

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
SRC_URI = "file://*"
    </pre>

<p>The 'SRC_URI' field specifies the source URI for the recipe. In this case, it uses the local filesystem ('file://*'). This means that the source files are expected to be in the same directory as the recipe file.</p>

<h3>6. Source Directory</h3>

<pre>
S = "${WORKDIR}"
    </pre>

<p>The 'S' variable sets the source directory to the working directory ('${WORKDIR}'). This is where the Yocto Project will find and build the source files.</p>

<h3>7. Inheritance</h3>

<pre>
inherit pkgconfig cmake
    </pre>

<p>The 'inherit' statement brings in the necessary classes for the recipe. In this case, it inherits from 'pkgconfig' (for managing pkg-config files) and 'cmake' (for CMake-based build systems).</p>

<p>With these steps, the Yocto Project can build and package the CMake-based "hello" application.</p>
