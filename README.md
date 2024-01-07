# meta-electoembedded-mp3

  this is a yocto layer used do domenstrate yocto project for beginners, providing simple mp3 example and integrate it inside yocto

## content

<ul>
  <li><a href="#first-yocto" > create your first yocto layer </a>
</li>
  <li>Tea</li>
  <li>Milk</li>
</ul>

<h3 id="first-yocto">create your first yocto layer </h3>

<p>in this section we will learn how to create first yocto layer</p>

    source oe-init-environment
    bitbake-layers create-layer meta-electroembedded-mp3
    bitbake-layers add-layer meta-electroembedded-mp3
