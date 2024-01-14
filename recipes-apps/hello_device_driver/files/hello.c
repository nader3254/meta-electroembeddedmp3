
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