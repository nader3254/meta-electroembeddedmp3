
<h1>Yocto Project Class - electroembedded</h1>

<p>This Yocto Project class, named <strong>electroembedded</strong>, showcases various functionalities and integration with common Yocto Project components.</p>

<h2>Inherited Classes</h2>

<pre>
inherit base cmake autotools
    </pre>

<p>The class inherits from the 'base', 'cmake', and 'autotools' classes, leveraging their functionalities in the Yocto Project build system.</p>

<h2>Custom Python Function</h2>

<pre>
python (){
    bb.plain("################ python autonomous #######################")
    bb.plain("################################ setfiles ##############################")
    bb.plain("################################ end of setfiles ##############################")
}
</pre>

<p>The class includes a custom Python function that prints autonomous messages related to file setup.</p>

<h2>Custom Tasks</h2>

<pre>
addtask hello after do_configure before do_compile 
    </pre>

<p>Adds a custom task named 'hello' to execute after 'do_configure' and before 'do_compile', echoing a message related to 'ELECTROEMBEDDED'.</p>

<h2>Compile and Install Steps</h2>

<pre>
do_compile(){
    # Compilation of CPP files
    # ...
}

do_install(){
    # Installation of compiled files
    # ...
}
</pre>

<p>Defines custom 'do_compile' and 'do_install' functions to compile and install CPP files, respectively.</p>

<h2>Package Prepend Python Function</h2>

<pre>
python do_package_prepend(){
    # Custom logic to modify FILES variable
    # ...
}
    </pre>

<p>A Python function 'do_package_prepend' modifies the 'FILES' variable to include custom logic related to file paths and installation directories.</p>

<h2>Custom Export Function</h2>

<pre>
EXPORT_FUNCTIONS do_exampleexport
    </pre>

<p>Exports the custom function 'do_exampleexport', allowing it to be used by other Yocto Project components.</p>

<h2>Custom Exported Function</h2>

<pre>
electroutils_do_exampleexport() {
    echo "################################ exporting example ##############################"
}
    </pre>

<p>Defines the custom exported function 'electroutils_do_exampleexport', which echoes a message related to exporting examples.</p>

<p>Feel free to explore and customize this Yocto Project class based on your specific needs and requirements.</p>
