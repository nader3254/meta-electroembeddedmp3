<h1>Yocto Project Recipe - PackageConfig Example</h1>

<h2>Step-by-Step Explanation</h2>

<h3>1. Summary and License</h3>

<pre>
SUMMARY = "Hello World package config"
LICENSE = "CLOSED"
    </pre>

<p>The 'SUMMARY' provides a brief description of the recipe, and 'LICENSE' specifies that it is a closed-source application.</p>

<h3>2. Source URI and Source Directory</h3>

<pre>
SRC_URI = "file://main.py"
S = "${WORKDIR}"
    </pre>

<p>'SRC_URI' points to the source file 'main.py' in the local filesystem. 'S' sets the source directory to the working directory ('${WORKDIR}').</p>

<h3>3. Dependencies</h3>

<pre>
DEPENDS = " python3"
    </pre>

<p>The recipe depends on Python 3 ('python3').</p>

<h3>4. Install Directory</h3>

<pre>
INSTALL_DIR := "/home/root/pkgconfig_example"
    </pre>

<p>Specifies the installation directory for the application.</p>

<h3>5. Package Configuration</h3>

<pre>
PACKAGECONFIG ?= ""
PACKAGECONFIG[feature1] = "enable-feature-1"
PACKAGECONFIG[feature2] = "enable-feature-2"
    </pre>

<p>Defines package configuration options. 'feature1' and 'feature2' can be enabled or disabled.</p>

<h3>6. Python Configuration Function</h3>

<pre>
def createConfig(file_path,f1,f2):
    # Python function to create config.py file based on PackageConfig options
    # ...
</pre>

<p>A Python function 'createConfig' is defined to generate the 'config.py' file based on PackageConfig options.</p>

<h3>7. Python Configuration during do_configure</h3>

<pre>
python do_configure(){
    # Python function to determine PackageConfig options and create config.py
    # ...
}
    </pre>

<p>The 'do_configure' function in Python determines the PackageConfig options, prints values, and uses 'createConfig' to generate 'config.py'.</p>

<h3>8. Installation of Files</h3>

<pre>
do_install(){
    # Installation of main.py and config.py
    # ...
}
    </pre>

<p>The 'do_install' function installs 'main.py' and 'config.py' into the specified directory.</p>

<h3>9. FILES Specification</h3>

<pre>
FILES_${PN} += " /home/root/pkgconfig_example/config.py \
                 /home/root/pkgconfig_example/main.py"
    </pre>

<p>Specifies the files to be included in the package.</p>

<h3>10. Python Application Code</h3>

```python
    # Python code in main.py
    import config

    def main():
        print("PAKAGECONFIG example")
        if(config.feature1):
            print("feature 1 is enabled")

        if(config.feature2):
            print("feature 2 is enabled")

    main()
```

<p>The Python code in 'main.py' imports 'config.py' and checks whether 'feature1' and 'feature2' are enabled, printing corresponding messages.</p>

<p>Feel free to explore and customize this Yocto Project recipe based on your specific needs and requirements.</p>
