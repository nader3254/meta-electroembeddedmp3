# meta-electoembedded-mp3

  this is a yocto layer used do domenstrate yocto project for beginners, providing simple mp3 example and integrate it inside yocto

## content

<ul>
  <li><a href="#first-yocto" > create your first yocto layer </a>
</li>
  <li><a href="#first-yocto-image" > create your first yocto image </a></li>
  <li>Milk</li>
</ul>

<h3 id="first-yocto">1. create your first yocto layer </h3>

<p>in this section we will learn how to create first yocto layer</p>

    source oe-init-environment
    bitbake-layers create-layer meta-electroembedded-mp3
    bitbake-layers add-layer meta-electroembedded-mp3




<h3 id="first-yocto-image">2. create your first yocto image </h3>

in yocto in order an image is just a recipe that describes how to make this image and add your packages inside it , We mean that in this section you will be able to make the following:-

		bitbake hello-mp3-image                                                            

as previously in order to create default yocto image we run this command:-

    bitbake core-image-minimal                                

so now we ar doing our custom one, to create our image we need to 
create recipe for the image .


Note: a recipe should be contained in a directory start with recipes-
now lets name the recipe for the images is recipes-images so we should go and create a directory with the same name recipes-images and beer in mind that the directory should be stored inside our layer

### Recipe structure :- 
	1- files: contain all source codes to be built in our recipe.
	2- images: contain all images recipes for our layer.
	3- classes: contain classes to be used later.
	4- packagegroups : contain all package classes for your layer.
	5- conf/machines : contain all development boards supported in the layer.

All the previous was just a directories and optional to exist of course depending on your application.



In our case we need the images directory to store our custom image recipe ,instead of building Linux image from scratch we will use the core image and modify it ,Why?because the poky Distribution is made to be a reference for developers and also a good practice technique.




### How ?
If you go to /poky/meta/recipes-core/images you will find all the recipes for the core-image-XXXXXX images we are focusing on core image minimal so we will copy paste this recipe to our custom recipe named like this hello-mp3-image.bb located in poky/meta-hello-mp3/recipes-images/images/hello-mp3-image.bb 

and here we go our image is ready and we can make 
	 
   bitbake electroembedded-mp3                                                                                                             


