
<h1>Yocto Project Recipe - External Linux Kernel Module</h1>

<h2>1. Summary, Description, and License</h2>

<pre>
SUMMARY = "Example of how to build an external Linux kernel module"
DESCRIPTION = "${SUMMARY}"
LICENSE = "CLOSED"
    </pre>

<p>Provides a brief summary, uses the same as description, and specifies the license as "CLOSED" for the example Linux kernel module.</p>

<h2>2. Inherit Module Class</h2>

<pre>
inherit module
    </pre>

<p>The 'inherit module' statement brings in the necessary classes for building kernel modules. It automatically names module packages with the "kernel-module-" prefix.</p>

<h2>3. Source URI and Source Directory</h2>

<pre>
SRC_URI = "file://Makefile \
           file://hello.c"
S = "${WORKDIR}"
    </pre>

<p>Specifies the source files needed for the recipe. In this case, it includes "Makefile" and "hello.c" from the local filesystem. 'S' sets the source directory to the working directory ('${WORKDIR}').</p>

<h2>4. Module Provides</h2>

<pre>
RPROVIDES_${PN} += "kernel-module-hello"
    </pre>

<p>Specifies that the module provides "kernel-module-hello." This is a requirement for compatibility with the Yocto Project build environment.</p>

<h2>5. Makefile</h2>

```makefile
    obj-m := hello.o

    SRC := $(shell pwd)

    all:
        $(MAKE) -C $(KERNEL_SRC) M=$(SRC)

    modules_install:
        $(MAKE) -C $(KERNEL_SRC) M=$(SRC) modules_install

    clean:
        rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c
        rm -f Module.markers Module.symvers modules.order
        rm -rf .tmp_versions Modules.symvers
```

<p>The Makefile contains instructions for building and cleaning the external Linux kernel module. It uses the 'obj-m' variable to specify the module name and provides targets for building, installing, and cleaning the module.</p>

<h2>6. hello.c</h2>

```c
    #include<linux/module.h>
    #include<linux/kernel.h>

    static int hello_init(void){
       printk(KERN_ALERT "Hello Electroembedded device driver /\n");
       return 0;
    }

    static void hello_exit(void){
       printk(KERN_INFO "Goodbye Electroembedded device driver \n");
    }

    module_init(hello_init);
    module_exit(hello_exit);

    MODULE_AUTHOR("Nader Hany & Ziad Gomaa");
    MODULE_LICENSE("GPL");
    MODULE_DESCRIPTION("Electroembedded's first driver with GPL licence.");
```

<p>The 'hello.c' file contains a simple Linux kernel module with an initialization and exit function. It also specifies authorship, license, and a description for the module.</p>