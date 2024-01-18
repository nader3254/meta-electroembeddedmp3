# meta-electoembedded-mp3

this is a yocto layer used do domenstrate yocto project for beginners, providing simple mp3 example and integrate it inside yocto

## content

<ul>
  <li><a href="#first-yocto" > create your first yocto layer </a>
</li>
  <li><a href="#first-yocto-image" > create your first yocto image </a></li>
    <li><a href="#first-yocto-image" > create your first yocto image </a></li>

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

### Layer structure :-

    1- recipe-*/files: contain all source codes to be built in our recipe.
    2- images: contain all images recipes for our layer.
    3- classes: contain classes to be used later.
    4- recipe-*/packagegroups : contain all package classes for your layer.
    5- conf/machines : contain all development boards supported in the layer.
    6- conf/distro : contain all distributions in the layer.


All the previous was just a directories and optional to exist of course depending on your application.

In our case we need the images directory to store our custom image recipe ,instead of building Linux image from scratch we will use the core image and modify it ,Why?because the poky Distribution is made to be a reference for developers and also a good practice technique.

### How ?

If you go to /poky/meta/recipes-core/images you will find all the recipes for the core-image-XXXXXX images we are focusing on core image minimal so we will copy paste this recipe to our custom recipe named like this hello-mp3-image.bb located in poky/meta-hello-mp3/recipes-images/images/hello-mp3-image.bb
and here we go our image is ready and we can make :-


    bitbake -k electroembedded-mp3



<h1><span class="section-number">3 </span>Syntax and Operators<a class="headerlink" href="#syntax-and-operators" title="Permalink to this heading"></a></h1>
<div class="line-block">
<div class="line"><br></div>
</div>
<p>BitBake files have their own syntax. The syntax has similarities to
several other languages but also has some unique features. This section
describes the available syntax and operators as well as provides
examples.</p>
<section id="basic-syntax">
<h2><span class="section-number">3.1 </span>Basic Syntax<a class="headerlink" href="#basic-syntax" title="Permalink to this heading"></a></h2>
<p>This section provides some basic syntax examples.</p>
<section id="basic-variable-setting">
<h3><span class="section-number">3.1.1 </span>Basic Variable Setting<a class="headerlink" href="#basic-variable-setting" title="Permalink to this heading"></a></h3>
<p>The following example sets <code class="docutils literal notranslate"><span class="pre">VARIABLE</span></code> to “value”. This assignment
occurs immediately as the statement is parsed. It is a “hard”
assignment.</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">VARIABLE</span> <span class="o">=</span> <span class="s2">"value"</span>
</pre></div>
</div>
<p>As expected, if you include leading or
trailing spaces as part of an assignment, the spaces are retained:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">VARIABLE</span> <span class="o">=</span> <span class="s2">" value"</span>
<span class="n">VARIABLE</span> <span class="o">=</span> <span class="s2">"value "</span>
</pre></div>
</div>
<p>Setting <code class="docutils literal notranslate"><span class="pre">VARIABLE</span></code> to “” sets
it to an empty string, while setting the variable to “ “ sets it to a
blank space (i.e. these are not the same values).</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">VARIABLE</span> <span class="o">=</span> <span class="s2">""</span>
<span class="n">VARIABLE</span> <span class="o">=</span> <span class="s2">" "</span>
</pre></div>
</div>
<p>You can use single quotes instead of double quotes when setting a
variable’s value. Doing so allows you to use values that contain the
double quote character:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">VARIABLE</span> <span class="o">=</span> <span class="s1">'I have a " in my value'</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Unlike in Bourne shells, single quotes work identically to double
quotes in all other ways. They do not suppress variable expansions.</p>
</div>
</section>
<section id="modifying-existing-variables">
<h3><span class="section-number">3.1.2 </span>Modifying Existing Variables<a class="headerlink" href="#modifying-existing-variables" title="Permalink to this heading"></a></h3>
<p>Sometimes you need to modify existing variables. Following are some
cases where you might find you want to modify an existing variable:</p>
<ul class="simple">
<li><p>Customize a recipe that uses the variable.</p></li>
<li><p>Change a variable’s default value used in a <code class="docutils literal notranslate"><span class="pre">*.bbclass</span></code> file.</p></li>
<li><p>Change the variable in a <code class="docutils literal notranslate"><span class="pre">*.bbappend</span></code> file to override the variable
in the original recipe.</p></li>
<li><p>Change the variable in a configuration file so that the value
overrides an existing configuration.</p></li>
</ul>
<p>Changing a variable value can sometimes depend on how the value was
originally assigned and also on the desired intent of the change. In
particular, when you append a value to a variable that has a default
value, the resulting value might not be what you expect. In this case,
the value you provide might replace the value rather than append to the
default value.</p>
<p>If after you have changed a variable’s value and something unexplained
occurs, you can use BitBake to check the actual value of the suspect
variable. You can make these checks for both configuration and recipe
level changes:</p>
<ul>
<li><p>For configuration changes, use the following:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>$ bitbake -e
</pre></div>
</div>
<p>This
command displays variable values after the configuration files (i.e.
<code class="docutils literal notranslate"><span class="pre">local.conf</span></code>, <code class="docutils literal notranslate"><span class="pre">bblayers.conf</span></code>, <code class="docutils literal notranslate"><span class="pre">bitbake.conf</span></code> and so forth)
have been parsed.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Variables that are exported to the environment are preceded by the
string “export” in the command’s output.</p>
</div>
</li>
<li><p>To find changes to a given variable in a specific recipe, use the
following:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>$ bitbake recipename -e | grep VARIABLENAME=\"
</pre></div>
</div>
<p>This command checks to see if the variable actually makes
it into a specific recipe.</p>
</li>
</ul>
</section>
<section id="line-joining">
<h3><span class="section-number">3.1.3 </span>Line Joining<a class="headerlink" href="#line-joining" title="Permalink to this heading"></a></h3>
<p>Outside of <a class="reference internal" href="#functions"><span class="std std-ref">functions</span></a>,
BitBake joins any line ending in
a backslash character (”\”) with the following line before parsing
statements. The most common use for the “\” character is to split
variable assignments over multiple lines, as in the following example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span> <span class="o">=</span> <span class="s2">"bar </span><span class="se">\</span>
<span class="s2">       baz </span><span class="se">\</span>
<span class="s2">       qaz"</span>
</pre></div>
</div>
<p>Both the “\” character and the newline
character that follow it are removed when joining lines. Thus, no
newline characters end up in the value of <code class="docutils literal notranslate"><span class="pre">FOO</span></code>.</p>
<p>Consider this additional example where the two assignments both assign
“barbaz” to <code class="docutils literal notranslate"><span class="pre">FOO</span></code>:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span> <span class="o">=</span> <span class="s2">"barbaz"</span>
<span class="n">FOO</span> <span class="o">=</span> <span class="s2">"bar</span><span class="se">\</span>
<span class="s2">baz"</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>BitBake does not interpret escape sequences like “\n” in variable
values. For these to have an effect, the value must be passed to some
utility that interprets escape sequences, such as
<code class="docutils literal notranslate"><span class="pre">printf</span></code> or <code class="docutils literal notranslate"><span class="pre">echo</span> <span class="pre">-n</span></code>.</p>
</div>
</section>
<section id="variable-expansion">
<h3><span class="section-number">3.1.4 </span>Variable Expansion<a class="headerlink" href="#variable-expansion" title="Permalink to this heading"></a></h3>
<p>Variables can reference the contents of other variables using a syntax
that is similar to variable expansion in Bourne shells. The following
assignments result in A containing “aval” and B evaluating to
“preavalpost”.</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">A</span> <span class="o">=</span> <span class="s2">"aval"</span>
<span class="n">B</span> <span class="o">=</span> <span class="s2">"pre$</span><span class="si">{A}</span><span class="s2">post"</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Unlike in Bourne shells, the curly braces are mandatory: Only <code class="docutils literal notranslate"><span class="pre">${FOO}</span></code> and not
<code class="docutils literal notranslate"><span class="pre">$FOO</span></code> is recognized as an expansion of <code class="docutils literal notranslate"><span class="pre">FOO</span></code>.</p>
</div>
<p>The “=” operator does not immediately expand variable references in the
right-hand side. Instead, expansion is deferred until the variable
assigned to is actually used. The result depends on the current values
of the referenced variables. The following example should clarify this
behavior:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>A = "${B} baz"
B = "${C} bar"
C = "foo"
*At this point, ${A} equals "foo bar baz"*
C = "qux"
*At this point, ${A} equals "qux bar baz"*
B = "norf"
*At this point, ${A} equals "norf baz"*
</pre></div>
</div>
<p>Contrast this behavior with the
<a class="reference internal" href="#immediate-variable-expansion"><span class="std std-ref">Immediate variable expansion (:=)</span></a> operator.</p>
<p>If the variable expansion syntax is used on a variable that does not
exist, the string is kept as is. For example, given the following
assignment, <code class="docutils literal notranslate"><span class="pre">BAR</span></code> expands to the literal string “${FOO}” as long as
<code class="docutils literal notranslate"><span class="pre">FOO</span></code> does not exist.</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">BAR</span> <span class="o">=</span> <span class="s2">"$</span><span class="si">{FOO}</span><span class="s2">"</span>
</pre></div>
</div>
</section>
<section id="setting-a-default-value">
<h3><span class="section-number">3.1.5 </span>Setting a default value (?=)<a class="headerlink" href="#setting-a-default-value" title="Permalink to this heading"></a></h3>
<p>You can use the “?=” operator to achieve a “softer” assignment for a
variable. This type of assignment allows you to define a variable if it
is undefined when the statement is parsed, but to leave the value alone
if the variable has a value. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>A ?= "aval"
</pre></div>
</div>
<p>If <code class="docutils literal notranslate"><span class="pre">A</span></code> is
set at the time this statement is parsed, the variable retains its
value. However, if <code class="docutils literal notranslate"><span class="pre">A</span></code> is not set, the variable is set to “aval”.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>This assignment is immediate. Consequently, if multiple “?=”
assignments to a single variable exist, the first of those ends up
getting used.</p>
</div>
</section>
<section id="setting-a-weak-default-value">
<h3><span class="section-number">3.1.6 </span>Setting a weak default value (??=)<a class="headerlink" href="#setting-a-weak-default-value" title="Permalink to this heading"></a></h3>
<p>The weak default value of a variable is the value which that variable
will expand to if no value has been assigned to it via any of the other
assignment operators. The “??=” operator takes effect immediately, replacing
any previously defined weak default value. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>W ??= "x"
A := "${W}" # Immediate variable expansion
W ??= "y"
B := "${W}" # Immediate variable expansion
W ??= "z"
C = "${W}"
W ?= "i"
</pre></div>
</div>
<p>After parsing we will have:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">A</span> <span class="o">=</span> <span class="s2">"x"</span>
<span class="n">B</span> <span class="o">=</span> <span class="s2">"y"</span>
<span class="n">C</span> <span class="o">=</span> <span class="s2">"i"</span>
<span class="n">W</span> <span class="o">=</span> <span class="s2">"i"</span>
</pre></div>
</div>
<p>Appending and prepending non-override style will not substitute the weak
default value, which means that after parsing:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>W ??= "x"
W += "y"
</pre></div>
</div>
<p>we will have:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">W</span> <span class="o">=</span> <span class="s2">" y"</span>
</pre></div>
</div>
<p>On the other hand, override-style appends/prepends/removes are applied after
any active weak default value has been substituted:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>W ??= "x"
W:append = "y"
</pre></div>
</div>
<p>After parsing we will have:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">W</span> <span class="o">=</span> <span class="s2">"xy"</span>
</pre></div>
</div>
</section>
<section id="immediate-variable-expansion">
<h3><span class="section-number">3.1.7 </span>Immediate variable expansion (:=)<a class="headerlink" href="#immediate-variable-expansion" title="Permalink to this heading"></a></h3>
<p>The “:=” operator results in a variable’s contents being expanded
immediately, rather than when the variable is actually used:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">T</span> <span class="o">=</span> <span class="s2">"123"</span>
<span class="n">A</span> <span class="o">:=</span> <span class="s2">"test $</span><span class="si">{T}</span><span class="s2">"</span>
<span class="n">T</span> <span class="o">=</span> <span class="s2">"456"</span>
<span class="n">B</span> <span class="o">:=</span> <span class="s2">"$</span><span class="si">{T}</span><span class="s2"> $</span><span class="si">{C}</span><span class="s2">"</span>
<span class="n">C</span> <span class="o">=</span> <span class="s2">"cval"</span>
<span class="n">C</span> <span class="o">:=</span> <span class="s2">"$</span><span class="si">{C}</span><span class="s2">append"</span>
</pre></div>
</div>
<p>In this example, <code class="docutils literal notranslate"><span class="pre">A</span></code> contains “test 123”, even though the final value
of <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-T"><span class="xref std std-term">T</span></a> is “456”. The variable <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-B"><span class="xref std std-term">B</span></a> will end up containing “456
cvalappend”. This is because references to undefined variables are
preserved as is during (immediate)expansion. This is in contrast to GNU
Make, where undefined variables expand to nothing. The variable <code class="docutils literal notranslate"><span class="pre">C</span></code>
contains “cvalappend” since <code class="docutils literal notranslate"><span class="pre">${C}</span></code> immediately expands to “cval”.</p>
</section>
<section id="appending-and-prepending-with-spaces">
<span id="appending-and-prepending"></span><h3><span class="section-number">3.1.8 </span>Appending (+=) and prepending (=+) With Spaces<a class="headerlink" href="#appending-and-prepending-with-spaces" title="Permalink to this heading"></a></h3>
<p>Appending and prepending values is common and can be accomplished using
the “+=” and “=+” operators. These operators insert a space between the
current value and prepended or appended value.</p>
<p>These operators take immediate effect during parsing. Here are some
examples:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">B</span> <span class="o">=</span> <span class="s2">"bval"</span>
<span class="n">B</span> <span class="o">+=</span> <span class="s2">"additionaldata"</span>
<span class="n">C</span> <span class="o">=</span> <span class="s2">"cval"</span>
<span class="n">C</span> <span class="o">=+</span> <span class="s2">"test"</span>
</pre></div>
</div>
<p>The variable <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-B"><span class="xref std std-term">B</span></a> contains “bval additionaldata” and <code class="docutils literal notranslate"><span class="pre">C</span></code> contains “test
cval”.</p>
</section>
<section id="appending-and-prepending-without-spaces">
<span id="id1"></span><h3><span class="section-number">3.1.9 </span>Appending (.=) and Prepending (=.) Without Spaces<a class="headerlink" href="#appending-and-prepending-without-spaces" title="Permalink to this heading"></a></h3>
<p>If you want to append or prepend values without an inserted space, use
the “.=” and “=.” operators.</p>
<p>These operators take immediate effect during parsing. Here are some
examples:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">B</span> <span class="o">=</span> <span class="s2">"bval"</span>
<span class="n">B</span> <span class="o">.=</span> <span class="s2">"additionaldata"</span>
<span class="n">C</span> <span class="o">=</span> <span class="s2">"cval"</span>
<span class="n">C</span> <span class="o">=.</span> <span class="s2">"test"</span>
</pre></div>
</div>
<p>The variable <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-B"><span class="xref std std-term">B</span></a> contains “bvaladditionaldata” and <code class="docutils literal notranslate"><span class="pre">C</span></code> contains
“testcval”.</p>
</section>
<section id="appending-and-prepending-override-style-syntax">
<h3><span class="section-number">3.1.10 </span>Appending and Prepending (Override Style Syntax)<a class="headerlink" href="#appending-and-prepending-override-style-syntax" title="Permalink to this heading"></a></h3>
<p>You can also append and prepend a variable’s value using an override
style syntax. When you use this syntax, no spaces are inserted.</p>
<p>These operators differ from the “:=”, “.=”, “=.”, “+=”, and “=+”
operators in that their effects are applied at variable expansion time
rather than being immediately applied. Here are some examples:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">B</span> <span class="o">=</span> <span class="s2">"bval"</span>
<span class="n">B</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">" additional data"</span>
<span class="n">C</span> <span class="o">=</span> <span class="s2">"cval"</span>
<span class="n">C</span><span class="p">:</span><span class="n">prepend</span> <span class="o">=</span> <span class="s2">"additional data "</span>
<span class="n">D</span> <span class="o">=</span> <span class="s2">"dval"</span>
<span class="n">D</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">"additional data"</span>
</pre></div>
</div>
<p>The variable <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-B"><span class="xref std std-term">B</span></a>
becomes “bval additional data” and <code class="docutils literal notranslate"><span class="pre">C</span></code> becomes “additional data cval”.
The variable <code class="docutils literal notranslate"><span class="pre">D</span></code> becomes “dvaladditional data”.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>You must control all spacing when you use the override syntax.</p>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>The overrides are applied in this order, “:append”, “:prepend”, “:remove”.</p>
</div>
<p>It is also possible to append and prepend to shell functions and
BitBake-style Python functions. See the “<a class="reference internal" href="#shell-functions"><span class="std std-ref">Shell Functions</span></a>” and “<a class="reference internal" href="#bitbake-style-python-functions"><span class="std std-ref">BitBake-Style Python Functions</span></a>”
sections for examples.</p>
</section>
<section id="removal-override-style-syntax">
<span id="removing-override-style-syntax"></span><h3><span class="section-number">3.1.11 </span>Removal (Override Style Syntax)<a class="headerlink" href="#removal-override-style-syntax" title="Permalink to this heading"></a></h3>
<p>You can remove values from lists using the removal override style
syntax. Specifying a value for removal causes all occurrences of that
value to be removed from the variable. Unlike “:append” and “:prepend”,
there is no need to add a leading or trailing space to the value.</p>
<p>When you use this syntax, BitBake expects one or more strings.
Surrounding spaces and spacing are preserved. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span> <span class="o">=</span> <span class="s2">"123 456 789 123456 123 456 123 456"</span>
<span class="n">FOO</span><span class="p">:</span><span class="n">remove</span> <span class="o">=</span> <span class="s2">"123"</span>
<span class="n">FOO</span><span class="p">:</span><span class="n">remove</span> <span class="o">=</span> <span class="s2">"456"</span>
<span class="n">FOO2</span> <span class="o">=</span> <span class="s2">" abc def ghi abcdef abc def abc def def"</span>
<span class="n">FOO2</span><span class="p">:</span><span class="n">remove</span> <span class="o">=</span> <span class="s2">"</span><span class="se">\</span>
<span class="s2">    def </span><span class="se">\</span>
<span class="s2">    abc </span><span class="se">\</span>
<span class="s2">    ghi </span><span class="se">\</span>
<span class="s2">    "</span>
</pre></div>
</div>
<p>The variable <code class="docutils literal notranslate"><span class="pre">FOO</span></code> becomes
“  789 123456    “ and <code class="docutils literal notranslate"><span class="pre">FOO2</span></code> becomes “    abcdef     “.</p>
<p>Like “:append” and “:prepend”, “:remove” is applied at variable
expansion time.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>The overrides are applied in this order, “:append”, “:prepend”, “:remove”.
This implies it is not possible to re-append previously removed strings.
However, one can undo a “:remove” by using an intermediate variable whose
content is passed to the “:remove” so that modifying the intermediate
variable equals to keeping the string in:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOOREMOVE</span> <span class="o">=</span> <span class="s2">"123 456 789"</span>
<span class="n">FOO</span><span class="p">:</span><span class="n">remove</span> <span class="o">=</span> <span class="s2">"$</span><span class="si">{FOOREMOVE}</span><span class="s2">"</span>
<span class="o">...</span>
<span class="n">FOOREMOVE</span> <span class="o">=</span> <span class="s2">"123 789"</span>
</pre></div>
</div>
<p>This expands to <code class="docutils literal notranslate"><span class="pre">FOO:remove</span> <span class="pre">=</span> <span class="pre">"123</span> <span class="pre">789"</span></code>.</p>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Override application order may not match variable parse history, i.e.
the output of <code class="docutils literal notranslate"><span class="pre">bitbake</span> <span class="pre">-e</span></code> may contain “:remove” before “:append”,
but the result will be removed string, because “:remove” is handled
last.</p>
</div>
</section>
<section id="override-style-operation-advantages">
<h3><span class="section-number">3.1.12 </span>Override Style Operation Advantages<a class="headerlink" href="#override-style-operation-advantages" title="Permalink to this heading"></a></h3>
<p>An advantage of the override style operations “:append”, “:prepend”, and
“:remove” as compared to the “+=” and “=+” operators is that the
override style operators provide guaranteed operations. For example,
consider a class <code class="docutils literal notranslate"><span class="pre">foo.bbclass</span></code> that needs to add the value “val” to
the variable <code class="docutils literal notranslate"><span class="pre">FOO</span></code>, and a recipe that uses <code class="docutils literal notranslate"><span class="pre">foo.bbclass</span></code> as follows:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">inherit</span> <span class="n">foo</span>
<span class="n">FOO</span> <span class="o">=</span> <span class="s2">"initial"</span>
</pre></div>
</div>
<p>If <code class="docutils literal notranslate"><span class="pre">foo.bbclass</span></code> uses the “+=” operator,
as follows, then the final value of <code class="docutils literal notranslate"><span class="pre">FOO</span></code> will be “initial”, which is
not what is desired:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span> <span class="o">+=</span> <span class="s2">"val"</span>
</pre></div>
</div>
<p>If, on the other hand, <code class="docutils literal notranslate"><span class="pre">foo.bbclass</span></code>
uses the “:append” operator, then the final value of <code class="docutils literal notranslate"><span class="pre">FOO</span></code> will be
“initial val”, as intended:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">" val"</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>It is never necessary to use “+=” together with “:append”. The following
sequence of assignments appends “barbaz” to FOO:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">"bar"</span>
<span class="n">FOO</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">"baz"</span>
</pre></div>
</div>
<p>The only effect of changing the second assignment in the previous
example to use “+=” would be to add a space before “baz” in the
appended value (due to how the “+=” operator works).</p>
</div>
<p>Another advantage of the override style operations is that you can
combine them with other overrides as described in the
“<a class="reference internal" href="#conditional-syntax-overrides"><span class="std std-ref">Conditional Syntax (Overrides)</span></a>” section.</p>
</section>
<section id="variable-flag-syntax">
<h3><span class="section-number">3.1.13 </span>Variable Flag Syntax<a class="headerlink" href="#variable-flag-syntax" title="Permalink to this heading"></a></h3>
<p>Variable flags are BitBake’s implementation of variable properties or
attributes. It is a way of tagging extra information onto a variable.
You can find more out about variable flags in general in the
“<a class="reference internal" href="#variable-flags"><span class="std std-ref">Variable Flags</span></a>” section.</p>
<p>You can define, append, and prepend values to variable flags. All the
standard syntax operations previously mentioned work for variable flags
except for override style syntax (i.e. “:prepend”, “:append”, and
“:remove”).</p>
<p>Here are some examples showing how to set variable flags:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span><span class="p">[</span><span class="n">a</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"abc"</span>
<span class="n">FOO</span><span class="p">[</span><span class="n">b</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"123"</span>
<span class="n">FOO</span><span class="p">[</span><span class="n">a</span><span class="p">]</span> <span class="o">+=</span> <span class="s2">"456"</span>
</pre></div>
</div>
<p>The variable <code class="docutils literal notranslate"><span class="pre">FOO</span></code> has two flags:
<code class="docutils literal notranslate"><span class="pre">[a]</span></code> and <code class="docutils literal notranslate"><span class="pre">[b]</span></code>. The flags are immediately set to “abc” and “123”,
respectively. The <code class="docutils literal notranslate"><span class="pre">[a]</span></code> flag becomes “abc 456”.</p>
<p>No need exists to pre-define variable flags. You can simply start using
them. One extremely common application is to attach some brief
documentation to a BitBake variable as follows:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">CACHE</span><span class="p">[</span><span class="n">doc</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"The directory holding the cache of the metadata."</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Variable flag names starting with an underscore (<code class="docutils literal notranslate"><span class="pre">_</span></code>) character
are allowed but are ignored by <code class="docutils literal notranslate"><span class="pre">d.getVarFlags("VAR")</span></code>
in Python code. Such flag names are used internally by BitBake.</p>
</div>
</section>
<section id="inline-python-variable-expansion">
<h3><span class="section-number">3.1.14 </span>Inline Python Variable Expansion<a class="headerlink" href="#inline-python-variable-expansion" title="Permalink to this heading"></a></h3>
<p>You can use inline Python variable expansion to set variables. Here is
an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">DATE</span> <span class="o">=</span> <span class="s2">"${@time.strftime('%Y%m</span><span class="si">%d</span><span class="s2">',time.gmtime())}"</span>
</pre></div>
</div>
<p>This example results in the <code class="docutils literal notranslate"><span class="pre">DATE</span></code> variable being set to the current date.</p>
<p>Probably the most common use of this feature is to extract the value of
variables from BitBake’s internal data dictionary, <code class="docutils literal notranslate"><span class="pre">d</span></code>. The following
lines select the values of a package name and its version number,
respectively:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">PN</span> <span class="o">=</span> <span class="s2">"${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0] or 'defaultpkgname'}"</span>
<span class="n">PV</span> <span class="o">=</span> <span class="s2">"${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[1] or '1.0'}"</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Inline Python expressions work just like variable expansions insofar as the
“=” and “:=” operators are concerned. Given the following assignment, foo()
is called each time FOO is expanded:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span> <span class="o">=</span> <span class="s2">"${@foo()}"</span>
</pre></div>
</div>
<p>Contrast this with the following immediate assignment, where foo() is only
called once, while the assignment is parsed:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span> <span class="o">:=</span> <span class="s2">"${@foo()}"</span>
</pre></div>
</div>
</div>
<p>For a different way to set variables with Python code during parsing,
see the
“<a class="reference internal" href="#anonymous-python-functions"><span class="std std-ref">Anonymous Python Functions</span></a>” section.</p>
</section>
<section id="unsetting-variables">
<h3><span class="section-number">3.1.15 </span>Unsetting variables<a class="headerlink" href="#unsetting-variables" title="Permalink to this heading"></a></h3>
<p>It is possible to completely remove a variable or a variable flag from
BitBake’s internal data dictionary by using the “unset” keyword. Here is
an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">unset</span> <span class="n">DATE</span>
<span class="n">unset</span> <span class="n">do_fetch</span><span class="p">[</span><span class="n">noexec</span><span class="p">]</span>
</pre></div>
</div>
<p>These two statements remove the <code class="docutils literal notranslate"><span class="pre">DATE</span></code> and the <code class="docutils literal notranslate"><span class="pre">do_fetch[noexec]</span></code> flag.</p>
</section>
<section id="providing-pathnames">
<h3><span class="section-number">3.1.16 </span>Providing Pathnames<a class="headerlink" href="#providing-pathnames" title="Permalink to this heading"></a></h3>
<p>When specifying pathnames for use with BitBake, do not use the tilde
(“~”) character as a shortcut for your home directory. Doing so might
cause BitBake to not recognize the path since BitBake does not expand
this character in the same way a shell would.</p>
<p>Instead, provide a fuller path as the following example illustrates:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>BBLAYERS ?= " \
    /home/scott-lenovo/LayerA \
"
</pre></div>
</div>
</section>
</section>
<section id="exporting-variables-to-the-environment">
<h2><span class="section-number">3.2 </span>Exporting Variables to the Environment<a class="headerlink" href="#exporting-variables-to-the-environment" title="Permalink to this heading"></a></h2>
<p>You can export variables to the environment of running tasks by using
the <code class="docutils literal notranslate"><span class="pre">export</span></code> keyword. For example, in the following example, the
<code class="docutils literal notranslate"><span class="pre">do_foo</span></code> task prints “value from the environment” when run:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">export</span> <span class="n">ENV_VARIABLE</span>
<span class="n">ENV_VARIABLE</span> <span class="o">=</span> <span class="s2">"value from the environment"</span>

<span class="n">do_foo</span><span class="p">()</span> <span class="p">{</span>
    <span class="n">bbplain</span> <span class="s2">"$ENV_VARIABLE"</span>
<span class="p">}</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>BitBake does not expand <code class="docutils literal notranslate"><span class="pre">$ENV_VARIABLE</span></code> in this case because it lacks the
obligatory <code class="docutils literal notranslate"><span class="pre">{}</span></code> . Rather, <code class="docutils literal notranslate"><span class="pre">$ENV_VARIABLE</span></code> is expanded by the shell.</p>
</div>
<p>It does not matter whether <code class="docutils literal notranslate"><span class="pre">export</span> <span class="pre">ENV_VARIABLE</span></code> appears before or
after assignments to <code class="docutils literal notranslate"><span class="pre">ENV_VARIABLE</span></code>.</p>
<p>It is also possible to combine <code class="docutils literal notranslate"><span class="pre">export</span></code> with setting a value for the
variable. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">export</span> <span class="n">ENV_VARIABLE</span> <span class="o">=</span> <span class="s2">"variable-value"</span>
</pre></div>
</div>
<p>In the output of <code class="docutils literal notranslate"><span class="pre">bitbake</span> <span class="pre">-e</span></code>, variables that are exported to the
environment are preceded by “export”.</p>
<p>Among the variables commonly exported to the environment are <code class="docutils literal notranslate"><span class="pre">CC</span></code> and
<code class="docutils literal notranslate"><span class="pre">CFLAGS</span></code>, which are picked up by many build systems.</p>
</section>
<section id="conditional-syntax-overrides">
<h2><span class="section-number">3.3 </span>Conditional Syntax (Overrides)<a class="headerlink" href="#conditional-syntax-overrides" title="Permalink to this heading"></a></h2>
<p>BitBake uses <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-OVERRIDES"><span class="xref std std-term">OVERRIDES</span></a> to control what
variables are overridden after BitBake parses recipes and configuration
files. This section describes how you can use <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-OVERRIDES"><span class="xref std std-term">OVERRIDES</span></a> as
conditional metadata, talks about key expansion in relationship to
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-OVERRIDES"><span class="xref std std-term">OVERRIDES</span></a>, and provides some examples to help with understanding.</p>
<section id="conditional-metadata">
<h3><span class="section-number">3.3.1 </span>Conditional Metadata<a class="headerlink" href="#conditional-metadata" title="Permalink to this heading"></a></h3>
<p>You can use <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-OVERRIDES"><span class="xref std std-term">OVERRIDES</span></a> to conditionally select a specific version of
a variable and to conditionally append or prepend the value of a
variable.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Overrides can only use lower-case characters, digits and dashes.
In particular, colons are not permitted in override names as they are used to
separate overrides from each other and from the variable name.</p>
</div>
<ul>
<li><p><em>Selecting a Variable:</em> The <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-OVERRIDES"><span class="xref std std-term">OVERRIDES</span></a> variable is a
colon-character-separated list that contains items for which you want
to satisfy conditions. Thus, if you have a variable that is
conditional on “arm”, and “arm” is in <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-OVERRIDES"><span class="xref std std-term">OVERRIDES</span></a>, then the
“arm”-specific version of the variable is used rather than the
non-conditional version. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">OVERRIDES</span> <span class="o">=</span> <span class="s2">"architecture:os:machine"</span>
<span class="n">TEST</span> <span class="o">=</span> <span class="s2">"default"</span>
<span class="n">TEST</span><span class="p">:</span><span class="n">os</span> <span class="o">=</span> <span class="s2">"osspecific"</span>
<span class="n">TEST</span><span class="p">:</span><span class="n">nooverride</span> <span class="o">=</span> <span class="s2">"othercondvalue"</span>
</pre></div>
</div>
<p>In this example, the <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-OVERRIDES"><span class="xref std std-term">OVERRIDES</span></a>
variable lists three overrides: “architecture”, “os”, and “machine”.
The variable <code class="docutils literal notranslate"><span class="pre">TEST</span></code> by itself has a default value of “default”. You
select the os-specific version of the <code class="docutils literal notranslate"><span class="pre">TEST</span></code> variable by appending
the “os” override to the variable (i.e. <code class="docutils literal notranslate"><span class="pre">TEST:os</span></code>).</p>
<p>To better understand this, consider a practical example that assumes
an OpenEmbedded metadata-based Linux kernel recipe file. The
following lines from the recipe file first set the kernel branch
variable <code class="docutils literal notranslate"><span class="pre">KBRANCH</span></code> to a default value, then conditionally override
that value based on the architecture of the build:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">KBRANCH</span> <span class="o">=</span> <span class="s2">"standard/base"</span>
<span class="n">KBRANCH</span><span class="p">:</span><span class="n">qemuarm</span> <span class="o">=</span> <span class="s2">"standard/arm-versatile-926ejs"</span>
<span class="n">KBRANCH</span><span class="p">:</span><span class="n">qemumips</span> <span class="o">=</span> <span class="s2">"standard/mti-malta32"</span>
<span class="n">KBRANCH</span><span class="p">:</span><span class="n">qemuppc</span> <span class="o">=</span> <span class="s2">"standard/qemuppc"</span>
<span class="n">KBRANCH</span><span class="p">:</span><span class="n">qemux86</span> <span class="o">=</span> <span class="s2">"standard/common-pc/base"</span>
<span class="n">KBRANCH</span><span class="p">:</span><span class="n">qemux86</span><span class="o">-</span><span class="mi">64</span> <span class="o">=</span> <span class="s2">"standard/common-pc-64/base"</span>
<span class="n">KBRANCH</span><span class="p">:</span><span class="n">qemumips64</span> <span class="o">=</span> <span class="s2">"standard/mti-malta64"</span>
</pre></div>
</div>
</li>
<li><p><em>Appending and Prepending:</em> BitBake also supports append and prepend
operations to variable values based on whether a specific item is
listed in <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-OVERRIDES"><span class="xref std std-term">OVERRIDES</span></a>. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">DEPENDS</span> <span class="o">=</span> <span class="s2">"glibc ncurses"</span>
<span class="n">OVERRIDES</span> <span class="o">=</span> <span class="s2">"machine:local"</span>
<span class="n">DEPENDS</span><span class="p">:</span><span class="n">append</span><span class="p">:</span><span class="n">machine</span> <span class="o">=</span> <span class="s2">"libmad"</span>
</pre></div>
</div>
<p>In this example, <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-DEPENDS"><span class="xref std std-term">DEPENDS</span></a> becomes “glibc ncurses libmad”.</p>
<p>Again, using an OpenEmbedded metadata-based kernel recipe file as an
example, the following lines will conditionally append to the
<code class="docutils literal notranslate"><span class="pre">KERNEL_FEATURES</span></code> variable based on the architecture:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">KERNEL_FEATURES</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">" $</span><span class="si">{KERNEL_EXTRA_FEATURES}</span><span class="s2">"</span>
<span class="n">KERNEL_FEATURES</span><span class="p">:</span><span class="n">append</span><span class="p">:</span><span class="n">qemux86</span><span class="o">=</span><span class="s2">" cfg/sound.scc cfg/paravirt_kvm.scc"</span>
<span class="n">KERNEL_FEATURES</span><span class="p">:</span><span class="n">append</span><span class="p">:</span><span class="n">qemux86</span><span class="o">-</span><span class="mi">64</span><span class="o">=</span><span class="s2">" cfg/sound.scc cfg/paravirt_kvm.scc"</span>
</pre></div>
</div>
</li>
<li><p><em>Setting a Variable for a Single Task:</em> BitBake supports setting a
variable just for the duration of a single task. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span><span class="p">:</span><span class="n">task</span><span class="o">-</span><span class="n">configure</span> <span class="o">=</span> <span class="s2">"val 1"</span>
<span class="n">FOO</span><span class="p">:</span><span class="n">task</span><span class="o">-</span><span class="nb">compile</span> <span class="o">=</span> <span class="s2">"val 2"</span>
</pre></div>
</div>
<p>In the
previous example, <code class="docutils literal notranslate"><span class="pre">FOO</span></code> has the value “val 1” while the
<code class="docutils literal notranslate"><span class="pre">do_configure</span></code> task is executed, and the value “val 2” while the
<code class="docutils literal notranslate"><span class="pre">do_compile</span></code> task is executed.</p>
<p>Internally, this is implemented by prepending the task (e.g.
“task-compile:”) to the value of
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-OVERRIDES"><span class="xref std std-term">OVERRIDES</span></a> for the local datastore of the
<code class="docutils literal notranslate"><span class="pre">do_compile</span></code> task.</p>
<p>You can also use this syntax with other combinations (e.g.
“<code class="docutils literal notranslate"><span class="pre">:prepend</span></code>”) as shown in the following example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">EXTRA_OEMAKE</span><span class="p">:</span><span class="n">prepend</span><span class="p">:</span><span class="n">task</span><span class="o">-</span><span class="nb">compile</span> <span class="o">=</span> <span class="s2">"$</span><span class="si">{PARALLEL_MAKE}</span><span class="s2"> "</span>
</pre></div>
</div>
</li>
</ul>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Before BitBake 1.52 (Honister 3.4), the syntax for <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-OVERRIDES"><span class="xref std std-term">OVERRIDES</span></a>
used <code class="docutils literal notranslate"><span class="pre">_</span></code> instead of <code class="docutils literal notranslate"><span class="pre">:</span></code>, so you will still find a lot of documentation
using <code class="docutils literal notranslate"><span class="pre">_append</span></code>, <code class="docutils literal notranslate"><span class="pre">_prepend</span></code>, and <code class="docutils literal notranslate"><span class="pre">_remove</span></code>, for example.</p>
<p>For details, see the
<a class="reference external" href="https://docs.yoctoproject.org/migration-guides/migration-3.4.html#override-syntax-changes">Overrides Syntax Changes</a>
section in the Yocto Project manual migration notes.</p>
</div>
</section>
<section id="key-expansion">
<h3><span class="section-number">3.3.2 </span>Key Expansion<a class="headerlink" href="#key-expansion" title="Permalink to this heading"></a></h3>
<p>Key expansion happens when the BitBake datastore is finalized. To better
understand this, consider the following example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>A${B} = "X"
B = "2"
A2 = "Y"
</pre></div>
</div>
<p>In this case, after all the parsing is complete, BitBake expands
<code class="docutils literal notranslate"><span class="pre">${B}</span></code> into “2”. This expansion causes <code class="docutils literal notranslate"><span class="pre">A2</span></code>, which was set to “Y”
before the expansion, to become “X”.</p>
</section>
<section id="examples">
<span id="variable-interaction-worked-examples"></span><h3><span class="section-number">3.3.3 </span>Examples<a class="headerlink" href="#examples" title="Permalink to this heading"></a></h3>
<p>Despite the previous explanations that show the different forms of
variable definitions, it can be hard to work out exactly what happens
when variable operators, conditional overrides, and unconditional
overrides are combined. This section presents some common scenarios
along with explanations for variable interactions that typically confuse
users.</p>
<p>There is often confusion concerning the order in which overrides and
various “append” operators take effect. Recall that an append or prepend
operation using “:append” and “:prepend” does not result in an immediate
assignment as would “+=”, “.=”, “=+”, or “=.”. Consider the following
example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">OVERRIDES</span> <span class="o">=</span> <span class="s2">"foo"</span>
<span class="n">A</span> <span class="o">=</span> <span class="s2">"Z"</span>
<span class="n">A</span><span class="p">:</span><span class="n">foo</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">"X"</span>
</pre></div>
</div>
<p>For this case,
<code class="docutils literal notranslate"><span class="pre">A</span></code> is unconditionally set to “Z” and “X” is unconditionally and
immediately appended to the variable <code class="docutils literal notranslate"><span class="pre">A:foo</span></code>. Because overrides have
not been applied yet, <code class="docutils literal notranslate"><span class="pre">A:foo</span></code> is set to “X” due to the append and
<code class="docutils literal notranslate"><span class="pre">A</span></code> simply equals “Z”.</p>
<p>Applying overrides, however, changes things. Since “foo” is listed in
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-OVERRIDES"><span class="xref std std-term">OVERRIDES</span></a>, the conditional variable <code class="docutils literal notranslate"><span class="pre">A</span></code> is replaced with the “foo”
version, which is equal to “X”. So effectively, <code class="docutils literal notranslate"><span class="pre">A:foo</span></code> replaces
<code class="docutils literal notranslate"><span class="pre">A</span></code>.</p>
<p>This next example changes the order of the override and the append:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">OVERRIDES</span> <span class="o">=</span> <span class="s2">"foo"</span>
<span class="n">A</span> <span class="o">=</span> <span class="s2">"Z"</span>
<span class="n">A</span><span class="p">:</span><span class="n">append</span><span class="p">:</span><span class="n">foo</span> <span class="o">=</span> <span class="s2">"X"</span>
</pre></div>
</div>
<p>For this case, before
overrides are handled, <code class="docutils literal notranslate"><span class="pre">A</span></code> is set to “Z” and <code class="docutils literal notranslate"><span class="pre">A:append:foo</span></code> is set
to “X”. Once the override for “foo” is applied, however, <code class="docutils literal notranslate"><span class="pre">A</span></code> gets
appended with “X”. Consequently, <code class="docutils literal notranslate"><span class="pre">A</span></code> becomes “ZX”. Notice that spaces
are not appended.</p>
<p>This next example has the order of the appends and overrides reversed
back as in the first example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">OVERRIDES</span> <span class="o">=</span> <span class="s2">"foo"</span>
<span class="n">A</span> <span class="o">=</span> <span class="s2">"Y"</span>
<span class="n">A</span><span class="p">:</span><span class="n">foo</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">"Z"</span>
<span class="n">A</span><span class="p">:</span><span class="n">foo</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">"X"</span>
</pre></div>
</div>
<p>For this case, before any overrides are resolved,
<code class="docutils literal notranslate"><span class="pre">A</span></code> is set to “Y” using an immediate assignment. After this immediate
assignment, <code class="docutils literal notranslate"><span class="pre">A:foo</span></code> is set to “Z”, and then further appended with “X”
leaving the variable set to “ZX”. Finally, applying the override for
“foo” results in the conditional variable <code class="docutils literal notranslate"><span class="pre">A</span></code> becoming “ZX” (i.e.
<code class="docutils literal notranslate"><span class="pre">A</span></code> is replaced with <code class="docutils literal notranslate"><span class="pre">A:foo</span></code>).</p>
<p>This final example mixes in some varying operators:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">A</span> <span class="o">=</span> <span class="s2">"1"</span>
<span class="n">A</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">"2"</span>
<span class="n">A</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">"3"</span>
<span class="n">A</span> <span class="o">+=</span> <span class="s2">"4"</span>
<span class="n">A</span> <span class="o">.=</span> <span class="s2">"5"</span>
</pre></div>
</div>
<p>For this case, the type of append
operators are affecting the order of assignments as BitBake passes
through the code multiple times. Initially, <code class="docutils literal notranslate"><span class="pre">A</span></code> is set to “1 45”
because of the three statements that use immediate operators. After
these assignments are made, BitBake applies the “:append” operations.
Those operations result in <code class="docutils literal notranslate"><span class="pre">A</span></code> becoming “1 4523”.</p>
</section>
</section>
<section id="sharing-functionality">
<h2><span class="section-number">3.4 </span>Sharing Functionality<a class="headerlink" href="#sharing-functionality" title="Permalink to this heading"></a></h2>
<p>BitBake allows for metadata sharing through include files (<code class="docutils literal notranslate"><span class="pre">.inc</span></code>) and
class files (<code class="docutils literal notranslate"><span class="pre">.bbclass</span></code>). For example, suppose you have a piece of
common functionality such as a task definition that you want to share
between more than one recipe. In this case, creating a <code class="docutils literal notranslate"><span class="pre">.bbclass</span></code> file
that contains the common functionality and then using the <code class="docutils literal notranslate"><span class="pre">inherit</span></code>
directive in your recipes to inherit the class would be a common way to
share the task.</p>
<p>This section presents the mechanisms BitBake provides to allow you to
share functionality between recipes. Specifically, the mechanisms
include <code class="docutils literal notranslate"><span class="pre">include</span></code>, <code class="docutils literal notranslate"><span class="pre">inherit</span></code>, <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-INHERIT"><span class="xref std std-term">INHERIT</span></a>, and <code class="docutils literal notranslate"><span class="pre">require</span></code>
directives.</p>
<section id="locating-include-and-class-files">
<h3><span class="section-number">3.4.1 </span>Locating Include and Class Files<a class="headerlink" href="#locating-include-and-class-files" title="Permalink to this heading"></a></h3>
<p>BitBake uses the <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BBPATH"><span class="xref std std-term">BBPATH</span></a> variable to locate
needed include and class files. Additionally, BitBake searches the
current directory for <code class="docutils literal notranslate"><span class="pre">include</span></code> and <code class="docutils literal notranslate"><span class="pre">require</span></code> directives.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>The BBPATH variable is analogous to the environment variable PATH .</p>
</div>
<p>In order for include and class files to be found by BitBake, they need
to be located in a “classes” subdirectory that can be found in
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BBPATH"><span class="xref std std-term">BBPATH</span></a>.</p>
</section>
<section id="inherit-directive">
<h3><span class="section-number">3.4.2 </span><code class="docutils literal notranslate"><span class="pre">inherit</span></code> Directive<a class="headerlink" href="#inherit-directive" title="Permalink to this heading"></a></h3>
<p>When writing a recipe or class file, you can use the <code class="docutils literal notranslate"><span class="pre">inherit</span></code>
directive to inherit the functionality of a class (<code class="docutils literal notranslate"><span class="pre">.bbclass</span></code>).
BitBake only supports this directive when used within recipe and class
files (i.e. <code class="docutils literal notranslate"><span class="pre">.bb</span></code> and <code class="docutils literal notranslate"><span class="pre">.bbclass</span></code>).</p>
<p>The <code class="docutils literal notranslate"><span class="pre">inherit</span></code> directive is a rudimentary means of specifying
functionality contained in class files that your recipes require. For
example, you can easily abstract out the tasks involved in building a
package that uses Autoconf and Automake and put those tasks into a class
file and then have your recipe inherit that class file.</p>
<p>As an example, your recipes could use the following directive to inherit
an <code class="docutils literal notranslate"><span class="pre">autotools.bbclass</span></code> file. The class file would contain common
functionality for using Autotools that could be shared across recipes:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">inherit</span> <span class="n">autotools</span>
</pre></div>
</div>
<p>In this case, BitBake would search for the directory
<code class="docutils literal notranslate"><span class="pre">classes/autotools.bbclass</span></code> in <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BBPATH"><span class="xref std std-term">BBPATH</span></a>.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>You can override any values and functions of the inherited class
within your recipe by doing so after the “inherit” statement.</p>
</div>
<p>If you want to use the directive to inherit multiple classes, separate
them with spaces. The following example shows how to inherit both the
<code class="docutils literal notranslate"><span class="pre">buildhistory</span></code> and <code class="docutils literal notranslate"><span class="pre">rm_work</span></code> classes:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">inherit</span> <span class="n">buildhistory</span> <span class="n">rm_work</span>
</pre></div>
</div>
<p>An advantage with the inherit directive as compared to both the
<a class="reference internal" href="#include-directive"><span class="std std-ref">include</span></a> and <a class="reference internal" href="#require-directive"><span class="std std-ref">require</span></a>
directives is that you can inherit class files conditionally. You can
accomplish this by using a variable expression after the <code class="docutils literal notranslate"><span class="pre">inherit</span></code>
statement. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>inherit ${VARNAME}
</pre></div>
</div>
<p>If <code class="docutils literal notranslate"><span class="pre">VARNAME</span></code> is
going to be set, it needs to be set before the <code class="docutils literal notranslate"><span class="pre">inherit</span></code> statement is
parsed. One way to achieve a conditional inherit in this case is to use
overrides:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">VARIABLE</span> <span class="o">=</span> <span class="s2">""</span>
<span class="n">VARIABLE</span><span class="p">:</span><span class="n">someoverride</span> <span class="o">=</span> <span class="s2">"myclass"</span>
</pre></div>
</div>
<p>Another method is by using anonymous Python. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">python</span> <span class="p">()</span> <span class="p">{</span>
    <span class="k">if</span> <span class="n">condition</span> <span class="o">==</span> <span class="n">value</span><span class="p">:</span>
        <span class="n">d</span><span class="o">.</span><span class="n">setVar</span><span class="p">(</span><span class="s1">'VARIABLE'</span><span class="p">,</span> <span class="s1">'myclass'</span><span class="p">)</span>
    <span class="k">else</span><span class="p">:</span>
        <span class="n">d</span><span class="o">.</span><span class="n">setVar</span><span class="p">(</span><span class="s1">'VARIABLE'</span><span class="p">,</span> <span class="s1">''</span><span class="p">)</span>
<span class="p">}</span>
</pre></div>
</div>
<p>Alternatively, you could use an in-line Python expression in the
following form:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>inherit ${@'classname' if condition else ''}
inherit ${@functionname(params)}
</pre></div>
</div>
<p>In all cases, if the expression evaluates to an
empty string, the statement does not trigger a syntax error because it
becomes a no-op.</p>
</section>
<section id="include-directive">
<h3><span class="section-number">3.4.3 </span><code class="docutils literal notranslate"><span class="pre">include</span></code> Directive<a class="headerlink" href="#include-directive" title="Permalink to this heading"></a></h3>
<p>BitBake understands the <code class="docutils literal notranslate"><span class="pre">include</span></code> directive. This directive causes
BitBake to parse whatever file you specify, and to insert that file at
that location. The directive is much like its equivalent in Make except
that if the path specified on the include line is a relative path,
BitBake locates the first file it can find within <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BBPATH"><span class="xref std std-term">BBPATH</span></a>.</p>
<p>The include directive is a more generic method of including
functionality as compared to the <a class="reference internal" href="#inherit-directive"><span class="std std-ref">inherit</span></a>
directive, which is restricted to class (i.e. <code class="docutils literal notranslate"><span class="pre">.bbclass</span></code>) files. The
include directive is applicable for any other kind of shared or
encapsulated functionality or configuration that does not suit a
<code class="docutils literal notranslate"><span class="pre">.bbclass</span></code> file.</p>
<p>As an example, suppose you needed a recipe to include some self-test
definitions:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">include</span> <span class="n">test_defs</span><span class="o">.</span><span class="n">inc</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>The include directive does not produce an error when the file cannot be
found.  Consequently, it is recommended that if the file you are including is
expected to exist, you should use <a class="reference internal" href="#require-inclusion"><span class="std std-ref">require</span></a> instead
of include . Doing so makes sure that an error is produced if the file cannot
be found.</p>
</div>
</section>
<section id="require-directive">
<span id="require-inclusion"></span><h3><span class="section-number">3.4.4 </span><code class="docutils literal notranslate"><span class="pre">require</span></code> Directive<a class="headerlink" href="#require-directive" title="Permalink to this heading"></a></h3>
<p>BitBake understands the <code class="docutils literal notranslate"><span class="pre">require</span></code> directive. This directive behaves
just like the <code class="docutils literal notranslate"><span class="pre">include</span></code> directive with the exception that BitBake
raises a parsing error if the file to be included cannot be found. Thus,
any file you require is inserted into the file that is being parsed at
the location of the directive.</p>
<p>The require directive, like the include directive previously described,
is a more generic method of including functionality as compared to the
<a class="reference internal" href="#inherit-directive"><span class="std std-ref">inherit</span></a> directive, which is restricted to class
(i.e. <code class="docutils literal notranslate"><span class="pre">.bbclass</span></code>) files. The require directive is applicable for any
other kind of shared or encapsulated functionality or configuration that
does not suit a <code class="docutils literal notranslate"><span class="pre">.bbclass</span></code> file.</p>
<p>Similar to how BitBake handles <a class="reference internal" href="#include-directive"><span class="std std-ref">include</span></a>, if
the path specified on the require line is a relative path, BitBake
locates the first file it can find within <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BBPATH"><span class="xref std std-term">BBPATH</span></a>.</p>
<p>As an example, suppose you have two versions of a recipe (e.g.
<code class="docutils literal notranslate"><span class="pre">foo_1.2.2.bb</span></code> and <code class="docutils literal notranslate"><span class="pre">foo_2.0.0.bb</span></code>) where each version contains some
identical functionality that could be shared. You could create an
include file named <code class="docutils literal notranslate"><span class="pre">foo.inc</span></code> that contains the common definitions
needed to build “foo”. You need to be sure <code class="docutils literal notranslate"><span class="pre">foo.inc</span></code> is located in the
same directory as your two recipe files as well. Once these conditions
are set up, you can share the functionality using a <code class="docutils literal notranslate"><span class="pre">require</span></code>
directive from within each recipe:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">require</span> <span class="n">foo</span><span class="o">.</span><span class="n">inc</span>
</pre></div>
</div>
</section>
<section id="inherit-configuration-directive">
<h3><span class="section-number">3.4.5 </span><code class="docutils literal notranslate"><span class="pre">INHERIT</span></code> Configuration Directive<a class="headerlink" href="#inherit-configuration-directive" title="Permalink to this heading"></a></h3>
<p>When creating a configuration file (<code class="docutils literal notranslate"><span class="pre">.conf</span></code>), you can use the
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-INHERIT"><span class="xref std std-term">INHERIT</span></a> configuration directive to inherit a
class. BitBake only supports this directive when used within a
configuration file.</p>
<p>As an example, suppose you needed to inherit a class file called
<code class="docutils literal notranslate"><span class="pre">abc.bbclass</span></code> from a configuration file as follows:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">INHERIT</span> <span class="o">+=</span> <span class="s2">"abc"</span>
</pre></div>
</div>
<p>This configuration directive causes the named class to be inherited at
the point of the directive during parsing. As with the <code class="docutils literal notranslate"><span class="pre">inherit</span></code>
directive, the <code class="docutils literal notranslate"><span class="pre">.bbclass</span></code> file must be located in a “classes”
subdirectory in one of the directories specified in <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BBPATH"><span class="xref std std-term">BBPATH</span></a>.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Because .conf files are parsed first during BitBake’s execution, using
INHERIT to inherit a class effectively inherits the class globally (i.e. for
all recipes).</p>
</div>
<p>If you want to use the directive to inherit multiple classes, you can
provide them on the same line in the <code class="docutils literal notranslate"><span class="pre">local.conf</span></code> file. Use spaces to
separate the classes. The following example shows how to inherit both
the <code class="docutils literal notranslate"><span class="pre">autotools</span></code> and <code class="docutils literal notranslate"><span class="pre">pkgconfig</span></code> classes:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">INHERIT</span> <span class="o">+=</span> <span class="s2">"autotools pkgconfig"</span>
</pre></div>
</div>
</section>
</section>
<section id="functions">
<h2><span class="section-number">3.5 </span>Functions<a class="headerlink" href="#functions" title="Permalink to this heading"></a></h2>
<p>As with most languages, functions are the building blocks that are used
to build up operations into tasks. BitBake supports these types of
functions:</p>
<ul class="simple">
<li><p><em>Shell Functions:</em> Functions written in shell script and executed
either directly as functions, tasks, or both. They can also be called
by other shell functions.</p></li>
<li><p><em>BitBake-Style Python Functions:</em> Functions written in Python and
executed by BitBake or other Python functions using
<code class="docutils literal notranslate"><span class="pre">bb.build.exec_func()</span></code>.</p></li>
<li><p><em>Python Functions:</em> Functions written in Python and executed by
Python.</p></li>
<li><p><em>Anonymous Python Functions:</em> Python functions executed automatically
during parsing.</p></li>
</ul>
<p>Regardless of the type of function, you can only define them in class
(<code class="docutils literal notranslate"><span class="pre">.bbclass</span></code>) and recipe (<code class="docutils literal notranslate"><span class="pre">.bb</span></code> or <code class="docutils literal notranslate"><span class="pre">.inc</span></code>) files.</p>
<section id="shell-functions">
<h3><span class="section-number">3.5.1 </span>Shell Functions<a class="headerlink" href="#shell-functions" title="Permalink to this heading"></a></h3>
<p>Functions written in shell script are executed either directly as
functions, tasks, or both. They can also be called by other shell
functions. Here is an example shell function definition:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">some_function</span> <span class="p">()</span> <span class="p">{</span>
    <span class="n">echo</span> <span class="s2">"Hello World"</span>
<span class="p">}</span>
</pre></div>
</div>
<p>When you create these types of functions in
your recipe or class files, you need to follow the shell programming
rules. The scripts are executed by <code class="docutils literal notranslate"><span class="pre">/bin/sh</span></code>, which may not be a bash
shell but might be something such as <code class="docutils literal notranslate"><span class="pre">dash</span></code>. You should not use
Bash-specific script (bashisms).</p>
<p>Overrides and override-style operators like <code class="docutils literal notranslate"><span class="pre">:append</span></code> and <code class="docutils literal notranslate"><span class="pre">:prepend</span></code>
can also be applied to shell functions. Most commonly, this application
would be used in a <code class="docutils literal notranslate"><span class="pre">.bbappend</span></code> file to modify functions in the main
recipe. It can also be used to modify functions inherited from classes.</p>
<p>As an example, consider the following:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">do_foo</span><span class="p">()</span> <span class="p">{</span>
    <span class="n">bbplain</span> <span class="n">first</span>
    <span class="n">fn</span>
<span class="p">}</span>

<span class="n">fn</span><span class="p">:</span><span class="n">prepend</span><span class="p">()</span> <span class="p">{</span>
    <span class="n">bbplain</span> <span class="n">second</span>
<span class="p">}</span>

<span class="n">fn</span><span class="p">()</span> <span class="p">{</span>
    <span class="n">bbplain</span> <span class="n">third</span>
<span class="p">}</span>

<span class="n">do_foo</span><span class="p">:</span><span class="n">append</span><span class="p">()</span> <span class="p">{</span>
    <span class="n">bbplain</span> <span class="n">fourth</span>
<span class="p">}</span>
</pre></div>
</div>
<p>Running <code class="docutils literal notranslate"><span class="pre">do_foo</span></code> prints the following:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">recipename</span> <span class="n">do_foo</span><span class="p">:</span> <span class="n">first</span>
<span class="n">recipename</span> <span class="n">do_foo</span><span class="p">:</span> <span class="n">second</span>
<span class="n">recipename</span> <span class="n">do_foo</span><span class="p">:</span> <span class="n">third</span>
<span class="n">recipename</span> <span class="n">do_foo</span><span class="p">:</span> <span class="n">fourth</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Overrides and override-style operators can be applied to any shell
function, not just <a class="reference internal" href="#tasks"><span class="std std-ref">tasks</span></a>.</p>
</div>
<p>You can use the <code class="docutils literal notranslate"><span class="pre">bitbake</span> <span class="pre">-e&nbsp;recipename</span></code> command to view the final
assembled function after all overrides have been applied.</p>
</section>
<section id="bitbake-style-python-functions">
<h3><span class="section-number">3.5.2 </span>BitBake-Style Python Functions<a class="headerlink" href="#bitbake-style-python-functions" title="Permalink to this heading"></a></h3>
<p>These functions are written in Python and executed by BitBake or other
Python functions using <code class="docutils literal notranslate"><span class="pre">bb.build.exec_func()</span></code>.</p>
<p>An example BitBake function is:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">python</span> <span class="n">some_python_function</span> <span class="p">()</span> <span class="p">{</span>
    <span class="n">d</span><span class="o">.</span><span class="n">setVar</span><span class="p">(</span><span class="s2">"TEXT"</span><span class="p">,</span> <span class="s2">"Hello World"</span><span class="p">)</span>
    <span class="nb">print</span> <span class="n">d</span><span class="o">.</span><span class="n">getVar</span><span class="p">(</span><span class="s2">"TEXT"</span><span class="p">)</span>
<span class="p">}</span>
</pre></div>
</div>
<p>Because the
Python “bb” and “os” modules are already imported, you do not need to
import these modules. Also in these types of functions, the datastore
(“d”) is a global variable and is always automatically available.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Variable expressions (e.g.  <code class="docutils literal notranslate"><span class="pre">${X}</span></code> ) are no longer expanded within Python
functions. This behavior is intentional in order to allow you to freely set
variable values to expandable expressions without having them expanded
prematurely. If you do wish to expand a variable within a Python function,
use <code class="docutils literal notranslate"><span class="pre">d.getVar("X")</span></code> . Or, for more complicated expressions, use <code class="docutils literal notranslate"><span class="pre">d.expand()</span></code>.</p>
</div>
<p>Similar to shell functions, you can also apply overrides and
override-style operators to BitBake-style Python functions.</p>
<p>As an example, consider the following:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">python</span> <span class="n">do_foo</span><span class="p">:</span><span class="n">prepend</span><span class="p">()</span> <span class="p">{</span>
    <span class="n">bb</span><span class="o">.</span><span class="n">plain</span><span class="p">(</span><span class="s2">"first"</span><span class="p">)</span>
<span class="p">}</span>

<span class="n">python</span> <span class="n">do_foo</span><span class="p">()</span> <span class="p">{</span>
    <span class="n">bb</span><span class="o">.</span><span class="n">plain</span><span class="p">(</span><span class="s2">"second"</span><span class="p">)</span>
<span class="p">}</span>

<span class="n">python</span> <span class="n">do_foo</span><span class="p">:</span><span class="n">append</span><span class="p">()</span> <span class="p">{</span>
    <span class="n">bb</span><span class="o">.</span><span class="n">plain</span><span class="p">(</span><span class="s2">"third"</span><span class="p">)</span>
<span class="p">}</span>
</pre></div>
</div>
<p>Running <code class="docutils literal notranslate"><span class="pre">do_foo</span></code> prints the following:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">recipename</span> <span class="n">do_foo</span><span class="p">:</span> <span class="n">first</span>
<span class="n">recipename</span> <span class="n">do_foo</span><span class="p">:</span> <span class="n">second</span>
<span class="n">recipename</span> <span class="n">do_foo</span><span class="p">:</span> <span class="n">third</span>
</pre></div>
</div>
<p>You can use the <code class="docutils literal notranslate"><span class="pre">bitbake</span> <span class="pre">-e&nbsp;recipename</span></code> command to view
the final assembled function after all overrides have been applied.</p>
</section>
<section id="python-functions">
<h3><span class="section-number">3.5.3 </span>Python Functions<a class="headerlink" href="#python-functions" title="Permalink to this heading"></a></h3>
<p>These functions are written in Python and are executed by other Python
code. Examples of Python functions are utility functions that you intend
to call from in-line Python or from within other Python functions. Here
is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="k">def</span> <span class="nf">get_depends</span><span class="p">(</span><span class="n">d</span><span class="p">):</span>
    <span class="k">if</span> <span class="n">d</span><span class="o">.</span><span class="n">getVar</span><span class="p">(</span><span class="s1">'SOMECONDITION'</span><span class="p">):</span>
        <span class="k">return</span> <span class="s2">"dependencywithcond"</span>
    <span class="k">else</span><span class="p">:</span>
        <span class="k">return</span> <span class="s2">"dependency"</span>

<span class="n">SOMECONDITION</span> <span class="o">=</span> <span class="s2">"1"</span>
<span class="n">DEPENDS</span> <span class="o">=</span> <span class="s2">"${@get_depends(d)}"</span>
</pre></div>
</div>
<p>This would result in <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-DEPENDS"><span class="xref std std-term">DEPENDS</span></a> containing <code class="docutils literal notranslate"><span class="pre">dependencywithcond</span></code>.</p>
<p>Here are some things to know about Python functions:</p>
<ul class="simple">
<li><p>Python functions can take parameters.</p></li>
<li><p>The BitBake datastore is not automatically available. Consequently,
you must pass it in as a parameter to the function.</p></li>
<li><p>The “bb” and “os” Python modules are automatically available. You do
not need to import them.</p></li>
</ul>
</section>
<section id="bitbake-style-python-functions-versus-python-functions">
<h3><span class="section-number">3.5.4 </span>BitBake-Style Python Functions Versus Python Functions<a class="headerlink" href="#bitbake-style-python-functions-versus-python-functions" title="Permalink to this heading"></a></h3>
<p>Following are some important differences between BitBake-style Python
functions and regular Python functions defined with “def”:</p>
<ul>
<li><p>Only BitBake-style Python functions can be <a class="reference internal" href="#tasks"><span class="std std-ref">tasks</span></a>.</p></li>
<li><p>Overrides and override-style operators can only be applied to
BitBake-style Python functions.</p></li>
<li><p>Only regular Python functions can take arguments and return values.</p></li>
<li><p><a class="reference internal" href="#variable-flags"><span class="std std-ref">Variable flags</span></a> such as
<code class="docutils literal notranslate"><span class="pre">[dirs]</span></code>, <code class="docutils literal notranslate"><span class="pre">[cleandirs]</span></code>, and <code class="docutils literal notranslate"><span class="pre">[lockfiles]</span></code> can be used on BitBake-style
Python functions, but not on regular Python functions.</p></li>
<li><p>BitBake-style Python functions generate a separate
<code class="docutils literal notranslate"><span class="pre">${</span></code><a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-T"><span class="xref std std-term">T</span></a><code class="docutils literal notranslate"><span class="pre">}/run.</span></code>function-name<code class="docutils literal notranslate"><span class="pre">.</span></code>pid
script that is executed to run the function, and also generate a log
file in <code class="docutils literal notranslate"><span class="pre">${T}/log.</span></code>function-name<code class="docutils literal notranslate"><span class="pre">.</span></code>pid if they are executed
as tasks.</p>
<p>Regular Python functions execute “inline” and do not generate any
files in <code class="docutils literal notranslate"><span class="pre">${T}</span></code>.</p>
</li>
<li><p>Regular Python functions are called with the usual Python syntax.
BitBake-style Python functions are usually tasks and are called
directly by BitBake, but can also be called manually from Python code
by using the <code class="docutils literal notranslate"><span class="pre">bb.build.exec_func()</span></code> function. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">bb</span><span class="o">.</span><span class="n">build</span><span class="o">.</span><span class="n">exec_func</span><span class="p">(</span><span class="s2">"my_bitbake_style_function"</span><span class="p">,</span> <span class="n">d</span><span class="p">)</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p><code class="docutils literal notranslate"><span class="pre">bb.build.exec_func()</span></code> can also be used to run shell functions from Python
code. If you want to run a shell function before a Python function within
the same task, then you can use a parent helper Python function that
starts by running the shell function with <code class="docutils literal notranslate"><span class="pre">bb.build.exec_func()</span></code> and then
runs the Python code.</p>
</div>
<p>To detect errors from functions executed with
<code class="docutils literal notranslate"><span class="pre">bb.build.exec_func()</span></code>, you can catch the <code class="docutils literal notranslate"><span class="pre">bb.build.FuncFailed</span></code>
exception.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>Functions in metadata (recipes and classes) should not themselves raise
<code class="docutils literal notranslate"><span class="pre">bb.build.FuncFailed</span></code>. Rather, <code class="docutils literal notranslate"><span class="pre">bb.build.FuncFailed</span></code> should be viewed as a
general indicator that the called function failed by raising an
exception. For example, an exception raised by <code class="docutils literal notranslate"><span class="pre">bb.fatal()</span></code> will be caught
inside <code class="docutils literal notranslate"><span class="pre">bb.build.exec_func()</span></code>, and a <code class="docutils literal notranslate"><span class="pre">bb.build.FuncFailed</span></code> will be raised in
response.</p>
</div>
</li>
</ul>
<p>Due to their simplicity, you should prefer regular Python functions over
BitBake-style Python functions unless you need a feature specific to
BitBake-style Python functions. Regular Python functions in metadata are
a more recent invention than BitBake-style Python functions, and older
code tends to use <code class="docutils literal notranslate"><span class="pre">bb.build.exec_func()</span></code> more often.</p>
</section>
<section id="anonymous-python-functions">
<h3><span class="section-number">3.5.5 </span>Anonymous Python Functions<a class="headerlink" href="#anonymous-python-functions" title="Permalink to this heading"></a></h3>
<p>Sometimes it is useful to set variables or perform other operations
programmatically during parsing. To do this, you can define special
Python functions, called anonymous Python functions, that run at the end
of parsing. For example, the following conditionally sets a variable
based on the value of another variable:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">python</span> <span class="p">()</span> <span class="p">{</span>
    <span class="k">if</span> <span class="n">d</span><span class="o">.</span><span class="n">getVar</span><span class="p">(</span><span class="s1">'SOMEVAR'</span><span class="p">)</span> <span class="o">==</span> <span class="s1">'value'</span><span class="p">:</span>
        <span class="n">d</span><span class="o">.</span><span class="n">setVar</span><span class="p">(</span><span class="s1">'ANOTHERVAR'</span><span class="p">,</span> <span class="s1">'value2'</span><span class="p">)</span>
<span class="p">}</span>
</pre></div>
</div>
<p>An equivalent way to mark a function as an anonymous function is to give it
the name “__anonymous”, rather than no name.</p>
<p>Anonymous Python functions always run at the end of parsing, regardless
of where they are defined. If a recipe contains many anonymous
functions, they run in the same order as they are defined within the
recipe. As an example, consider the following snippet:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">python</span> <span class="p">()</span> <span class="p">{</span>
    <span class="n">d</span><span class="o">.</span><span class="n">setVar</span><span class="p">(</span><span class="s1">'FOO'</span><span class="p">,</span> <span class="s1">'foo 2'</span><span class="p">)</span>
<span class="p">}</span>

<span class="n">FOO</span> <span class="o">=</span> <span class="s2">"foo 1"</span>

<span class="n">python</span> <span class="p">()</span> <span class="p">{</span>
    <span class="n">d</span><span class="o">.</span><span class="n">appendVar</span><span class="p">(</span><span class="s1">'BAR'</span><span class="p">,</span><span class="s1">' bar 2'</span><span class="p">)</span>
<span class="p">}</span>

<span class="n">BAR</span> <span class="o">=</span> <span class="s2">"bar 1"</span>
</pre></div>
</div>
<p>The previous example is conceptually
equivalent to the following snippet:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span> <span class="o">=</span> <span class="s2">"foo 1"</span>
<span class="n">BAR</span> <span class="o">=</span> <span class="s2">"bar 1"</span>
<span class="n">FOO</span> <span class="o">=</span> <span class="s2">"foo 2"</span>
<span class="n">BAR</span> <span class="o">+=</span> <span class="s2">"bar 2"</span>
</pre></div>
</div>
<p><code class="docutils literal notranslate"><span class="pre">FOO</span></code> ends up with the value “foo 2”, and
<code class="docutils literal notranslate"><span class="pre">BAR</span></code> with the value “bar 1 bar 2”. Just as in the second snippet, the
values set for the variables within the anonymous functions become
available to tasks, which always run after parsing.</p>
<p>Overrides and override-style operators such as “<code class="docutils literal notranslate"><span class="pre">:append</span></code>” are applied
before anonymous functions run. In the following example, <code class="docutils literal notranslate"><span class="pre">FOO</span></code> ends
up with the value “foo from anonymous”:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">FOO</span> <span class="o">=</span> <span class="s2">"foo"</span>
<span class="n">FOO</span><span class="p">:</span><span class="n">append</span> <span class="o">=</span> <span class="s2">" from outside"</span>

<span class="n">python</span> <span class="p">()</span> <span class="p">{</span>
    <span class="n">d</span><span class="o">.</span><span class="n">setVar</span><span class="p">(</span><span class="s2">"FOO"</span><span class="p">,</span> <span class="s2">"foo from anonymous"</span><span class="p">)</span>
<span class="p">}</span>
</pre></div>
</div>
<p>For methods
you can use with anonymous Python functions, see the
“<a class="reference internal" href="#functions-you-can-call-from-within-python"><span class="std std-ref">Functions You Can Call From Within Python</span></a>”
section. For a different method to run Python code during parsing, see
the “<a class="reference internal" href="#inline-python-variable-expansion"><span class="std std-ref">Inline Python Variable Expansion</span></a>” section.</p>
</section>
<section id="flexible-inheritance-for-class-functions">
<h3><span class="section-number">3.5.6 </span>Flexible Inheritance for Class Functions<a class="headerlink" href="#flexible-inheritance-for-class-functions" title="Permalink to this heading"></a></h3>
<p>Through coding techniques and the use of <code class="docutils literal notranslate"><span class="pre">EXPORT_FUNCTIONS</span></code>, BitBake
supports exporting a function from a class such that the class function
appears as the default implementation of the function, but can still be
called if a recipe inheriting the class needs to define its own version
of the function.</p>
<p>To understand the benefits of this feature, consider the basic scenario
where a class defines a task function and your recipe inherits the
class. In this basic scenario, your recipe inherits the task function as
defined in the class. If desired, your recipe can add to the start and
end of the function by using the “:prepend” or “:append” operations
respectively, or it can redefine the function completely. However, if it
redefines the function, there is no means for it to call the class
version of the function. <code class="docutils literal notranslate"><span class="pre">EXPORT_FUNCTIONS</span></code> provides a mechanism that
enables the recipe’s version of the function to call the original
version of the function.</p>
<p>To make use of this technique, you need the following things in place:</p>
<ul>
<li><p>The class needs to define the function as follows:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">classname_functionname</span>
</pre></div>
</div>
<p>For example, if you have a class file
<code class="docutils literal notranslate"><span class="pre">bar.bbclass</span></code> and a function named <code class="docutils literal notranslate"><span class="pre">do_foo</span></code>, the class must
define the function as follows:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">bar_do_foo</span>
</pre></div>
</div>
</li>
<li><p>The class needs to contain the <code class="docutils literal notranslate"><span class="pre">EXPORT_FUNCTIONS</span></code> statement as
follows:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">EXPORT_FUNCTIONS</span> <span class="n">functionname</span>
</pre></div>
</div>
<p>For example, continuing with
the same example, the statement in the <code class="docutils literal notranslate"><span class="pre">bar.bbclass</span></code> would be as
follows:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">EXPORT_FUNCTIONS</span> <span class="n">do_foo</span>
</pre></div>
</div>
</li>
<li><p>You need to call the function appropriately from within your recipe.
Continuing with the same example, if your recipe needs to call the
class version of the function, it should call <code class="docutils literal notranslate"><span class="pre">bar_do_foo</span></code>.
Assuming <code class="docutils literal notranslate"><span class="pre">do_foo</span></code> was a shell function and <code class="docutils literal notranslate"><span class="pre">EXPORT_FUNCTIONS</span></code> was
used as above, the recipe’s function could conditionally call the
class version of the function as follows:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">do_foo</span><span class="p">()</span> <span class="p">{</span>
    <span class="k">if</span> <span class="p">[</span> <span class="n">somecondition</span> <span class="p">]</span> <span class="p">;</span> <span class="n">then</span>
        <span class="n">bar_do_foo</span>
    <span class="k">else</span>
        <span class="c1"># Do something else</span>
    <span class="n">fi</span>
<span class="p">}</span>
</pre></div>
</div>
<p>To call your modified version of the function as defined in your recipe,
call it as <code class="docutils literal notranslate"><span class="pre">do_foo</span></code>.</p>
</li>
</ul>
<p>With these conditions met, your single recipe can freely choose between
the original function as defined in the class file and the modified
function in your recipe. If you do not set up these conditions, you are
limited to using one function or the other.</p>
</section>
</section>
<section id="tasks">
<h2><span class="section-number">3.6 </span>Tasks<a class="headerlink" href="#tasks" title="Permalink to this heading"></a></h2>
<p>Tasks are BitBake execution units that make up the steps that BitBake
can run for a given recipe. Tasks are only supported in recipes and
classes (i.e. in <code class="docutils literal notranslate"><span class="pre">.bb</span></code> files and files included or inherited from
<code class="docutils literal notranslate"><span class="pre">.bb</span></code> files). By convention, tasks have names that start with “do_”.</p>
<section id="promoting-a-function-to-a-task">
<h3><span class="section-number">3.6.1 </span>Promoting a Function to a Task<a class="headerlink" href="#promoting-a-function-to-a-task" title="Permalink to this heading"></a></h3>
<p>Tasks are either <a class="reference internal" href="#shell-functions"><span class="std std-ref">shell functions</span></a> or
<a class="reference internal" href="#bitbake-style-python-functions"><span class="std std-ref">BitBake-style Python functions</span></a>
that have been promoted to tasks by using the <code class="docutils literal notranslate"><span class="pre">addtask</span></code> command. The
<code class="docutils literal notranslate"><span class="pre">addtask</span></code> command can also optionally describe dependencies between
the task and other tasks. Here is an example that shows how to define a
task and declare some dependencies:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">python</span> <span class="n">do_printdate</span> <span class="p">()</span> <span class="p">{</span>
    <span class="kn">import</span> <span class="nn">time</span>
    <span class="nb">print</span> <span class="n">time</span><span class="o">.</span><span class="n">strftime</span><span class="p">(</span><span class="s1">'%Y%m</span><span class="si">%d</span><span class="s1">'</span><span class="p">,</span> <span class="n">time</span><span class="o">.</span><span class="n">gmtime</span><span class="p">())</span>
<span class="p">}</span>
<span class="n">addtask</span> <span class="n">printdate</span> <span class="n">after</span> <span class="n">do_fetch</span> <span class="n">before</span> <span class="n">do_build</span>
</pre></div>
</div>
<p>The first argument to <code class="docutils literal notranslate"><span class="pre">addtask</span></code> is the name
of the function to promote to a task. If the name does not start with
“do_”, “do_” is implicitly added, which enforces the convention that all
task names start with “do_”.</p>
<p>In the previous example, the <code class="docutils literal notranslate"><span class="pre">do_printdate</span></code> task becomes a dependency
of the <code class="docutils literal notranslate"><span class="pre">do_build</span></code> task, which is the default task (i.e. the task run
by the <code class="docutils literal notranslate"><span class="pre">bitbake</span></code> command unless another task is specified explicitly).
Additionally, the <code class="docutils literal notranslate"><span class="pre">do_printdate</span></code> task becomes dependent upon the
<code class="docutils literal notranslate"><span class="pre">do_fetch</span></code> task. Running the <code class="docutils literal notranslate"><span class="pre">do_build</span></code> task results in the
<code class="docutils literal notranslate"><span class="pre">do_printdate</span></code> task running first.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>If you try out the previous example, you might see that the
<code class="docutils literal notranslate"><span class="pre">do_printdate</span></code>
task is only run the first time you build the recipe with the
<code class="docutils literal notranslate"><span class="pre">bitbake</span></code>
command. This is because BitBake considers the task “up-to-date”
after that initial run. If you want to force the task to always be
rerun for experimentation purposes, you can make BitBake always
consider the task “out-of-date” by using the
<a class="reference internal" href="#variable-flags"><span class="std std-ref">[nostamp]</span></a>
variable flag, as follows:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">do_printdate</span><span class="p">[</span><span class="n">nostamp</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"1"</span>
</pre></div>
</div>
<p>You can also explicitly run the task and provide the
-f option as follows:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>$ bitbake recipe -c printdate -f
</pre></div>
</div>
<p>When manually selecting a task to run with the bitbake <code class="docutils literal notranslate"><span class="pre">recipe</span>
<span class="pre">-c</span> <span class="pre">task</span></code> command, you can omit the “do_” prefix as part of the task
name.</p>
</div>
<p>You might wonder about the practical effects of using <code class="docutils literal notranslate"><span class="pre">addtask</span></code>
without specifying any dependencies as is done in the following example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">addtask</span> <span class="n">printdate</span>
</pre></div>
</div>
<p>In this example, assuming dependencies have not been
added through some other means, the only way to run the task is by
explicitly selecting it with <code class="docutils literal notranslate"><span class="pre">bitbake</span></code>&nbsp;recipe&nbsp;<code class="docutils literal notranslate"><span class="pre">-c</span> <span class="pre">printdate</span></code>. You
can use the <code class="docutils literal notranslate"><span class="pre">do_listtasks</span></code> task to list all tasks defined in a recipe
as shown in the following example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>$ bitbake recipe -c listtasks
</pre></div>
</div>
<p>For more information on task dependencies, see the
“<a class="reference internal" href="bitbake-user-manual-execution.html#dependencies"><span class="std std-ref">Dependencies</span></a>” section.</p>
<p>See the “<a class="reference internal" href="#variable-flags"><span class="std std-ref">Variable Flags</span></a>” section for information
on variable flags you can use with tasks.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>While it’s infrequent, it’s possible to define multiple tasks as
dependencies when calling <code class="docutils literal notranslate"><span class="pre">addtask</span></code>. For example, here’s a snippet
from the OpenEmbedded class file <code class="docutils literal notranslate"><span class="pre">package_tar.bbclass</span></code>:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">addtask</span> <span class="n">package_write_tar</span> <span class="n">before</span> <span class="n">do_build</span> <span class="n">after</span> <span class="n">do_packagedata</span> <span class="n">do_package</span>
</pre></div>
</div>
<p>Note how the <code class="docutils literal notranslate"><span class="pre">package_write_tar</span></code> task has to wait until both of
<code class="docutils literal notranslate"><span class="pre">do_packagedata</span></code> and <code class="docutils literal notranslate"><span class="pre">do_package</span></code> complete.</p>
</div>
</section>
<section id="deleting-a-task">
<h3><span class="section-number">3.6.2 </span>Deleting a Task<a class="headerlink" href="#deleting-a-task" title="Permalink to this heading"></a></h3>
<p>As well as being able to add tasks, you can delete them. Simply use the
<code class="docutils literal notranslate"><span class="pre">deltask</span></code> command to delete a task. For example, to delete the example
task used in the previous sections, you would use:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">deltask</span> <span class="n">printdate</span>
</pre></div>
</div>
<p>If you delete a task using the <code class="docutils literal notranslate"><span class="pre">deltask</span></code> command and the task has
dependencies, the dependencies are not reconnected. For example, suppose
you have three tasks named <code class="docutils literal notranslate"><span class="pre">do_a</span></code>, <code class="docutils literal notranslate"><span class="pre">do_b</span></code>, and <code class="docutils literal notranslate"><span class="pre">do_c</span></code>.
Furthermore, <code class="docutils literal notranslate"><span class="pre">do_c</span></code> is dependent on <code class="docutils literal notranslate"><span class="pre">do_b</span></code>, which in turn is
dependent on <code class="docutils literal notranslate"><span class="pre">do_a</span></code>. Given this scenario, if you use <code class="docutils literal notranslate"><span class="pre">deltask</span></code> to
delete <code class="docutils literal notranslate"><span class="pre">do_b</span></code>, the implicit dependency relationship between <code class="docutils literal notranslate"><span class="pre">do_c</span></code>
and <code class="docutils literal notranslate"><span class="pre">do_a</span></code> through <code class="docutils literal notranslate"><span class="pre">do_b</span></code> no longer exists, and <code class="docutils literal notranslate"><span class="pre">do_c</span></code>
dependencies are not updated to include <code class="docutils literal notranslate"><span class="pre">do_a</span></code>. Thus, <code class="docutils literal notranslate"><span class="pre">do_c</span></code> is free
to run before <code class="docutils literal notranslate"><span class="pre">do_a</span></code>.</p>
<p>If you want dependencies such as these to remain intact, use the
<code class="docutils literal notranslate"><span class="pre">[noexec]</span></code> varflag to disable the task instead of using the
<code class="docutils literal notranslate"><span class="pre">deltask</span></code> command to delete it:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">do_b</span><span class="p">[</span><span class="n">noexec</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"1"</span>
</pre></div>
</div>
</section>
<section id="passing-information-into-the-build-task-environment">
<h3><span class="section-number">3.6.3 </span>Passing Information Into the Build Task Environment<a class="headerlink" href="#passing-information-into-the-build-task-environment" title="Permalink to this heading"></a></h3>
<p>When running a task, BitBake tightly controls the shell execution
environment of the build tasks to make sure unwanted contamination from
the build machine cannot influence the build.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>By default, BitBake cleans the environment to include only those
things exported or listed in its passthrough list to ensure that the
build environment is reproducible and consistent. You can prevent this
“cleaning” by setting the <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BB_PRESERVE_ENV"><span class="xref std std-term">BB_PRESERVE_ENV</span></a> variable.</p>
</div>
<p>Consequently, if you do want something to get passed into the build task
environment, you must take these two steps:</p>
<ol class="arabic">
<li><p>Tell BitBake to load what you want from the environment into the
datastore. You can do so through the
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BB_ENV_PASSTHROUGH"><span class="xref std std-term">BB_ENV_PASSTHROUGH</span></a> and
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BB_ENV_PASSTHROUGH_ADDITIONS"><span class="xref std std-term">BB_ENV_PASSTHROUGH_ADDITIONS</span></a> variables. For
example, assume you want to prevent the build system from accessing
your <code class="docutils literal notranslate"><span class="pre">$HOME/.ccache</span></code> directory. The following command adds the
the environment variable <code class="docutils literal notranslate"><span class="pre">CCACHE_DIR</span></code> to BitBake’s passthrough
list to allow that variable into the datastore:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">export</span> <span class="n">BB_ENV_PASSTHROUGH_ADDITIONS</span><span class="o">=</span><span class="s2">"$BB_ENV_PASSTHROUGH_ADDITIONS CCACHE_DIR"</span>
</pre></div>
</div>
</li>
<li><p>Tell BitBake to export what you have loaded into the datastore to the
task environment of every running task. Loading something from the
environment into the datastore (previous step) only makes it
available in the datastore. To export it to the task environment of
every running task, use a command similar to the following in your
local configuration file <code class="docutils literal notranslate"><span class="pre">local.conf</span></code> or your distribution
configuration file:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">export</span> <span class="n">CCACHE_DIR</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>A side effect of the previous steps is that BitBake records the
variable as a dependency of the build process in things like the
setscene checksums. If doing so results in unnecessary rebuilds of
tasks, you can also flag the variable so that the setscene code
ignores the dependency when it creates checksums.</p>
</div>
</li>
</ol>
<p>Sometimes, it is useful to be able to obtain information from the
original execution environment. BitBake saves a copy of the original
environment into a special variable named <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BB_ORIGENV"><span class="xref std std-term">BB_ORIGENV</span></a>.</p>
<p>The <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BB_ORIGENV"><span class="xref std std-term">BB_ORIGENV</span></a> variable returns a datastore object that can be
queried using the standard datastore operators such as
<code class="docutils literal notranslate"><span class="pre">getVar(,</span> <span class="pre">False)</span></code>. The datastore object is useful, for example, to
find the original <code class="docutils literal notranslate"><span class="pre">DISPLAY</span></code> variable. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">origenv</span> <span class="o">=</span> <span class="n">d</span><span class="o">.</span><span class="n">getVar</span><span class="p">(</span><span class="s2">"BB_ORIGENV"</span><span class="p">,</span> <span class="kc">False</span><span class="p">)</span>
<span class="n">bar</span> <span class="o">=</span> <span class="n">origenv</span><span class="o">.</span><span class="n">getVar</span><span class="p">(</span><span class="s2">"BAR"</span><span class="p">,</span> <span class="kc">False</span><span class="p">)</span>
</pre></div>
</div>
<p>The previous example returns <code class="docutils literal notranslate"><span class="pre">BAR</span></code> from the original execution
environment.</p>
</section>
</section>
<section id="variable-flags">
<h2><span class="section-number">3.7 </span>Variable Flags<a class="headerlink" href="#variable-flags" title="Permalink to this heading"></a></h2>
<p>Variable flags (varflags) help control a task’s functionality and
dependencies. BitBake reads and writes varflags to the datastore using
the following command forms:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">variable</span> <span class="o">=</span> <span class="n">d</span><span class="o">.</span><span class="n">getVarFlags</span><span class="p">(</span><span class="s2">"variable"</span><span class="p">)</span>
<span class="bp">self</span><span class="o">.</span><span class="n">d</span><span class="o">.</span><span class="n">setVarFlags</span><span class="p">(</span><span class="s2">"FOO"</span><span class="p">,</span> <span class="p">{</span><span class="s2">"func"</span><span class="p">:</span> <span class="kc">True</span><span class="p">})</span>
</pre></div>
</div>
<p>When working with varflags, the same syntax, with the exception of
overrides, applies. In other words, you can set, append, and prepend
varflags just like variables. See the
“<a class="reference internal" href="#variable-flag-syntax"><span class="std std-ref">Variable Flag Syntax</span></a>” section for details.</p>
<p>BitBake has a defined set of varflags available for recipes and classes.
Tasks support a number of these flags which control various
functionality of the task:</p>
<ul>
<li><p><code class="docutils literal notranslate"><span class="pre">[cleandirs]</span></code>: Empty directories that should be created before
the task runs. Directories that already exist are removed and
recreated to empty them.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[depends]</span></code>: Controls inter-task dependencies. See the
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-DEPENDS"><span class="xref std std-term">DEPENDS</span></a> variable and the
“<a class="reference internal" href="#inter-task-dependencies"><span class="std std-ref">Inter-Task Dependencies</span></a>” section for more information.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[deptask]</span></code>: Controls task build-time dependencies. See the
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-DEPENDS"><span class="xref std std-term">DEPENDS</span></a> variable and the “<a class="reference internal" href="#build-dependencies"><span class="std std-ref">Build Dependencies</span></a>” section for more information.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[dirs]</span></code>: Directories that should be created before the task
runs. Directories that already exist are left as is. The last
directory listed is used as the current working directory for the
task.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[file-checksums]</span></code>: Controls the file dependencies for a task. The
baseline file list is the set of files associated with
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-SRC_URI"><span class="xref std std-term">SRC_URI</span></a>. May be used to set additional dependencies on
files not associated with <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-SRC_URI"><span class="xref std std-term">SRC_URI</span></a>.</p>
<p>The value set to the list is a file-boolean pair where the first
value is the file name and the second is whether or not it
physically exists on the filesystem.</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">do_configure</span><span class="p">[</span><span class="n">file</span><span class="o">-</span><span class="n">checksums</span><span class="p">]</span> <span class="o">+=</span> <span class="s2">"$</span><span class="si">{MY_DIRPATH}</span><span class="s2">/my-file.txt:True"</span>
</pre></div>
</div>
<p>It is important to record any paths which the task looked at and
which didn’t exist. This means that if these do exist at a later
time, the task can be rerun with the new additional files. The
“exists” True or False value after the path allows this to be
handled.</p>
</li>
<li><p><code class="docutils literal notranslate"><span class="pre">[lockfiles]</span></code>: Specifies one or more lockfiles to lock while the
task executes. Only one task may hold a lockfile, and any task that
attempts to lock an already locked file will block until the lock is
released. You can use this variable flag to accomplish mutual
exclusion.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[network]</span></code>: When set to “1”, allows a task to access the network. By
default, only the <code class="docutils literal notranslate"><span class="pre">do_fetch</span></code> task is granted network access. Recipes
shouldn’t access the network outside of <code class="docutils literal notranslate"><span class="pre">do_fetch</span></code> as it usually
undermines fetcher source mirroring, image and licence manifests, software
auditing and supply chain security.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[noexec]</span></code>: When set to “1”, marks the task as being empty, with
no execution required. You can use the <code class="docutils literal notranslate"><span class="pre">[noexec]</span></code> flag to set up
tasks as dependency placeholders, or to disable tasks defined
elsewhere that are not needed in a particular recipe.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[nostamp]</span></code>: When set to “1”, tells BitBake to not generate a
stamp file for a task, which implies the task should always be
executed.</p>
<div class="admonition caution">
<p class="admonition-title">Caution</p>
<p>Any task that depends (possibly indirectly) on a <code class="docutils literal notranslate"><span class="pre">[nostamp]</span></code> task will
always be executed as well. This can cause unnecessary rebuilding if you
are not careful.</p>
</div>
</li>
<li><p><code class="docutils literal notranslate"><span class="pre">[number_threads]</span></code>: Limits tasks to a specific number of
simultaneous threads during execution. This varflag is useful when
your build host has a large number of cores but certain tasks need to
be rate-limited due to various kinds of resource constraints (e.g. to
avoid network throttling). <code class="docutils literal notranslate"><span class="pre">number_threads</span></code> works similarly to the
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BB_NUMBER_THREADS"><span class="xref std std-term">BB_NUMBER_THREADS</span></a> variable but is task-specific.</p>
<p>Set the value globally. For example, the following makes sure the
<code class="docutils literal notranslate"><span class="pre">do_fetch</span></code> task uses no more than two simultaneous execution
threads: do_fetch[number_threads] = “2”</p>
<div class="admonition warning">
<p class="admonition-title">Warning</p>
<ul class="simple">
<li><p>Setting the varflag in individual recipes rather than globally
can result in unpredictable behavior.</p></li>
<li><p>Setting the varflag to a value greater than the value used in
the <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BB_NUMBER_THREADS"><span class="xref std std-term">BB_NUMBER_THREADS</span></a> variable causes <code class="docutils literal notranslate"><span class="pre">number_threads</span></code> to
have no effect.</p></li>
</ul>
</div>
</li>
<li><p><code class="docutils literal notranslate"><span class="pre">[postfuncs]</span></code>: List of functions to call after the completion of
the task.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[prefuncs]</span></code>: List of functions to call before the task executes.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[rdepends]</span></code>: Controls inter-task runtime dependencies. See the
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RDEPENDS"><span class="xref std std-term">RDEPENDS</span></a> variable, the
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RRECOMMENDS"><span class="xref std std-term">RRECOMMENDS</span></a> variable, and the
“<a class="reference internal" href="#inter-task-dependencies"><span class="std std-ref">Inter-Task Dependencies</span></a>” section for
more information.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[rdeptask]</span></code>: Controls task runtime dependencies. See the
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RDEPENDS"><span class="xref std std-term">RDEPENDS</span></a> variable, the
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RRECOMMENDS"><span class="xref std std-term">RRECOMMENDS</span></a> variable, and the
“<a class="reference internal" href="#runtime-dependencies"><span class="std std-ref">Runtime Dependencies</span></a>” section for more
information.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[recideptask]</span></code>: When set in conjunction with <code class="docutils literal notranslate"><span class="pre">recrdeptask</span></code>,
specifies a task that should be inspected for additional
dependencies.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[recrdeptask]</span></code>: Controls task recursive runtime dependencies.
See the <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RDEPENDS"><span class="xref std std-term">RDEPENDS</span></a> variable, the
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RRECOMMENDS"><span class="xref std std-term">RRECOMMENDS</span></a> variable, and the
“<a class="reference internal" href="#recursive-dependencies"><span class="std std-ref">Recursive Dependencies</span></a>” section for
more information.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[stamp-extra-info]</span></code>: Extra stamp information to append to the
task’s stamp. As an example, OpenEmbedded uses this flag to allow
machine-specific tasks.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[umask]</span></code>: The umask to run the task under.</p></li>
</ul>
<p>Several varflags are useful for controlling how signatures are
calculated for variables. For more information on this process, see the
“<a class="reference internal" href="bitbake-user-manual-execution.html#checksums-signatures"><span class="std std-ref">Checksums (Signatures)</span></a>” section.</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">[vardeps]</span></code>: Specifies a space-separated list of additional
variables to add to a variable’s dependencies for the purposes of
calculating its signature. Adding variables to this list is useful,
for example, when a function refers to a variable in a manner that
does not allow BitBake to automatically determine that the variable
is referred to.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[vardepsexclude]</span></code>: Specifies a space-separated list of variables
that should be excluded from a variable’s dependencies for the
purposes of calculating its signature.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[vardepvalue]</span></code>: If set, instructs BitBake to ignore the actual
value of the variable and instead use the specified value when
calculating the variable’s signature.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">[vardepvalueexclude]</span></code>: Specifies a pipe-separated list of
strings to exclude from the variable’s value when calculating the
variable’s signature.</p></li>
</ul>
</section>
<section id="events">
<h2><span class="section-number">3.8 </span>Events<a class="headerlink" href="#events" title="Permalink to this heading"></a></h2>
<p>BitBake allows installation of event handlers within recipe and class
files. Events are triggered at certain points during operation, such as
the beginning of operation against a given recipe (i.e. <code class="docutils literal notranslate"><span class="pre">*.bb</span></code>), the
start of a given task, a task failure, a task success, and so forth. The
intent is to make it easy to do things like email notification on build
failures.</p>
<p>Following is an example event handler that prints the name of the event
and the content of the <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-FILE"><span class="xref std std-term">FILE</span></a> variable:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">addhandler</span> <span class="n">myclass_eventhandler</span>
<span class="n">python</span> <span class="n">myclass_eventhandler</span><span class="p">()</span> <span class="p">{</span>
    <span class="kn">from</span> <span class="nn">bb.event</span> <span class="kn">import</span> <span class="n">getName</span>
    <span class="nb">print</span><span class="p">(</span><span class="s2">"The name of the Event is </span><span class="si">%s</span><span class="s2">"</span> <span class="o">%</span> <span class="n">getName</span><span class="p">(</span><span class="n">e</span><span class="p">))</span>
    <span class="nb">print</span><span class="p">(</span><span class="s2">"The file we run for is </span><span class="si">%s</span><span class="s2">"</span> <span class="o">%</span> <span class="n">d</span><span class="o">.</span><span class="n">getVar</span><span class="p">(</span><span class="s1">'FILE'</span><span class="p">))</span>
<span class="p">}</span>
<span class="n">myclass_eventhandler</span><span class="p">[</span><span class="n">eventmask</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"bb.event.BuildStarted</span>
<span class="n">bb</span><span class="o">.</span><span class="n">event</span><span class="o">.</span><span class="n">BuildCompleted</span><span class="s2">"</span>
</pre></div>
</div>
<p>In the previous example, an eventmask has been
set so that the handler only sees the “BuildStarted” and
“BuildCompleted” events. This event handler gets called every time an
event matching the eventmask is triggered. A global variable “e” is
defined, which represents the current event. With the <code class="docutils literal notranslate"><span class="pre">getName(e)</span></code>
method, you can get the name of the triggered event. The global
datastore is available as “d”. In legacy code, you might see “e.data”
used to get the datastore. However, realize that “e.data” is deprecated
and you should use “d” going forward.</p>
<p>The context of the datastore is appropriate to the event in question.
For example, “BuildStarted” and “BuildCompleted” events run before any
tasks are executed so would be in the global configuration datastore
namespace. No recipe-specific metadata exists in that namespace. The
“BuildStarted” and “BuildCompleted” events also run in the main
cooker/server process rather than any worker context. Thus, any changes
made to the datastore would be seen by other cooker/server events within
the current build but not seen outside of that build or in any worker
context. Task events run in the actual tasks in question consequently
have recipe-specific and task-specific contents. These events run in the
worker context and are discarded at the end of task execution.</p>
<p>During a standard build, the following common events might occur. The
following events are the most common kinds of events that most metadata
might have an interest in viewing:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.ConfigParsed()</span></code>: Fired when the base configuration; which
consists of <code class="docutils literal notranslate"><span class="pre">bitbake.conf</span></code>, <code class="docutils literal notranslate"><span class="pre">base.bbclass</span></code> and any global
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-INHERIT"><span class="xref std std-term">INHERIT</span></a> statements; has been parsed. You can see multiple such
events when each of the workers parse the base configuration or if
the server changes configuration and reparses. Any given datastore
only has one such event executed against it, however. If
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BB_INVALIDCONF"><span class="xref std std-term">BB_INVALIDCONF</span></a> is set in the datastore by the event
handler, the configuration is reparsed and a new event triggered,
allowing the metadata to update configuration.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.HeartbeatEvent()</span></code>: Fires at regular time intervals of one
second. You can configure the interval time using the
<code class="docutils literal notranslate"><span class="pre">BB_HEARTBEAT_EVENT</span></code> variable. The event’s “time” attribute is the
<code class="docutils literal notranslate"><span class="pre">time.time()</span></code> value when the event is triggered. This event is
useful for activities such as system state monitoring.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.ParseStarted()</span></code>: Fired when BitBake is about to start
parsing recipes. This event’s “total” attribute represents the number
of recipes BitBake plans to parse.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.ParseProgress()</span></code>: Fired as parsing progresses. This
event’s “current” attribute is the number of recipes parsed as well
as the “total” attribute.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.ParseCompleted()</span></code>: Fired when parsing is complete. This
event’s “cached”, “parsed”, “skipped”, “virtuals”, “masked”, and
“errors” attributes provide statistics for the parsing results.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.BuildStarted()</span></code>: Fired when a new build starts. BitBake
fires multiple “BuildStarted” events (one per configuration) when
multiple configuration (multiconfig) is enabled.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.build.TaskStarted()</span></code>: Fired when a task starts. This event’s
“taskfile” attribute points to the recipe from which the task
originates. The “taskname” attribute, which is the task’s name,
includes the <code class="docutils literal notranslate"><span class="pre">do_</span></code> prefix, and the “logfile” attribute point to
where the task’s output is stored. Finally, the “time” attribute is
the task’s execution start time.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.build.TaskInvalid()</span></code>: Fired if BitBake tries to execute a task
that does not exist.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.build.TaskFailedSilent()</span></code>: Fired for setscene tasks that fail
and should not be presented to the user verbosely.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.build.TaskFailed()</span></code>: Fired for normal tasks that fail.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.build.TaskSucceeded()</span></code>: Fired when a task successfully
completes.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.BuildCompleted()</span></code>: Fired when a build finishes.</p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.cooker.CookerExit()</span></code>: Fired when the BitBake server/cooker
shuts down. This event is usually only seen by the UIs as a sign they
should also shutdown.</p></li>
</ul>
<p>This next list of example events occur based on specific requests to the
server. These events are often used to communicate larger pieces of
information from the BitBake server to other parts of BitBake such as
user interfaces:</p>
<ul class="simple">
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.TreeDataPreparationStarted()</span></code></p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.TreeDataPreparationProgress()</span></code></p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.TreeDataPreparationCompleted()</span></code></p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.DepTreeGenerated()</span></code></p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.CoreBaseFilesFound()</span></code></p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.ConfigFilePathFound()</span></code></p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.FilesMatchingFound()</span></code></p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.ConfigFilesFound()</span></code></p></li>
<li><p><code class="docutils literal notranslate"><span class="pre">bb.event.TargetsTreeGenerated()</span></code></p></li>
</ul>
</section>
<section id="variants-class-extension-mechanism">
<span id="id2"></span><h2><span class="section-number">3.9 </span>Variants — Class Extension Mechanism<a class="headerlink" href="#variants-class-extension-mechanism" title="Permalink to this heading"></a></h2>
<p>BitBake supports multiple incarnations of a recipe file via the
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BBCLASSEXTEND"><span class="xref std std-term">BBCLASSEXTEND</span></a> variable.</p>
<p>The <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BBCLASSEXTEND"><span class="xref std std-term">BBCLASSEXTEND</span></a> variable is a space separated list of classes used
to “extend” the recipe for each variant. Here is an example that results in a
second incarnation of the current recipe being available. This second
incarnation will have the “native” class inherited.</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">BBCLASSEXTEND</span> <span class="o">=</span> <span class="s2">"native"</span>
</pre></div>
</div>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>The mechanism for this class extension is extremely specific to the
implementation. Usually, the recipe’s <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-PROVIDES"><span class="xref std std-term">PROVIDES</span></a> , <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-PN"><span class="xref std std-term">PN</span></a> , and
<a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-DEPENDS"><span class="xref std std-term">DEPENDS</span></a> variables would need to be modified by the extension
class. For specific examples, see the OE-Core native , nativesdk , and
multilib classes.</p>
</div>
</section>
<section id="dependencies">
<h2><span class="section-number">3.10 </span>Dependencies<a class="headerlink" href="#dependencies" title="Permalink to this heading"></a></h2>
<p>To allow for efficient parallel processing, BitBake handles dependencies
at the task level. Dependencies can exist both between tasks within a
single recipe and between tasks in different recipes. Following are
examples of each:</p>
<ul class="simple">
<li><p>For tasks within a single recipe, a recipe’s <code class="docutils literal notranslate"><span class="pre">do_configure</span></code> task
might need to complete before its <code class="docutils literal notranslate"><span class="pre">do_compile</span></code> task can run.</p></li>
<li><p>For tasks in different recipes, one recipe’s <code class="docutils literal notranslate"><span class="pre">do_configure</span></code> task
might require another recipe’s <code class="docutils literal notranslate"><span class="pre">do_populate_sysroot</span></code> task to finish
first such that the libraries and headers provided by the other
recipe are available.</p></li>
</ul>
<p>This section describes several ways to declare dependencies. Remember,
even though dependencies are declared in different ways, they are all
simply dependencies between tasks.</p>
<section id="dependencies-internal-to-the-bb-file">
<span id="id3"></span><h3><span class="section-number">3.10.1 </span>Dependencies Internal to the <code class="docutils literal notranslate"><span class="pre">.bb</span></code> File<a class="headerlink" href="#dependencies-internal-to-the-bb-file" title="Permalink to this heading"></a></h3>
<p>BitBake uses the <code class="docutils literal notranslate"><span class="pre">addtask</span></code> directive to manage dependencies that are
internal to a given recipe file. You can use the <code class="docutils literal notranslate"><span class="pre">addtask</span></code> directive
to indicate when a task is dependent on other tasks or when other tasks
depend on that recipe. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">addtask</span> <span class="n">printdate</span> <span class="n">after</span> <span class="n">do_fetch</span> <span class="n">before</span> <span class="n">do_build</span>
</pre></div>
</div>
<p>In this example, the <code class="docutils literal notranslate"><span class="pre">do_printdate</span></code> task
depends on the completion of the <code class="docutils literal notranslate"><span class="pre">do_fetch</span></code> task, and the <code class="docutils literal notranslate"><span class="pre">do_build</span></code>
task depends on the completion of the <code class="docutils literal notranslate"><span class="pre">do_printdate</span></code> task.</p>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>For a task to run, it must be a direct or indirect dependency of some
other task that is scheduled to run.</p>
<p>For illustration, here are some examples:</p>
<ul>
<li><p>The directive <code class="docutils literal notranslate"><span class="pre">addtask</span> <span class="pre">mytask</span> <span class="pre">before</span> <span class="pre">do_configure</span></code> causes
<code class="docutils literal notranslate"><span class="pre">do_mytask</span></code> to run before <code class="docutils literal notranslate"><span class="pre">do_configure</span></code> runs. Be aware that
<code class="docutils literal notranslate"><span class="pre">do_mytask</span></code> still only runs if its <a class="reference internal" href="bitbake-user-manual-execution.html#checksums-signatures"><span class="std std-ref">input
checksum</span></a> has changed since the last time it was
run. Changes to the input checksum of <code class="docutils literal notranslate"><span class="pre">do_mytask</span></code> also
indirectly cause <code class="docutils literal notranslate"><span class="pre">do_configure</span></code> to run.</p></li>
<li><p>The directive <code class="docutils literal notranslate"><span class="pre">addtask</span> <span class="pre">mytask</span> <span class="pre">after</span> <span class="pre">do_configure</span></code> by itself
never causes <code class="docutils literal notranslate"><span class="pre">do_mytask</span></code> to run. <code class="docutils literal notranslate"><span class="pre">do_mytask</span></code> can still be run
manually as follows:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>$ bitbake recipe -c mytask
</pre></div>
</div>
<p>Declaring <code class="docutils literal notranslate"><span class="pre">do_mytask</span></code> as a dependency of some other task that is
scheduled to run also causes it to run. Regardless, the task runs after
<code class="docutils literal notranslate"><span class="pre">do_configure</span></code>.</p>
</li>
</ul>
</div>
</section>
<section id="build-dependencies">
<h3><span class="section-number">3.10.2 </span>Build Dependencies<a class="headerlink" href="#build-dependencies" title="Permalink to this heading"></a></h3>
<p>BitBake uses the <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-DEPENDS"><span class="xref std std-term">DEPENDS</span></a> variable to manage
build time dependencies. The <code class="docutils literal notranslate"><span class="pre">[deptask]</span></code> varflag for tasks signifies
the task of each item listed in <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-DEPENDS"><span class="xref std std-term">DEPENDS</span></a> that must complete before
that task can be executed. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">do_configure</span><span class="p">[</span><span class="n">deptask</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"do_populate_sysroot"</span>
</pre></div>
</div>
<p>In this example, the <code class="docutils literal notranslate"><span class="pre">do_populate_sysroot</span></code> task
of each item in <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-DEPENDS"><span class="xref std std-term">DEPENDS</span></a> must complete before <code class="docutils literal notranslate"><span class="pre">do_configure</span></code> can
execute.</p>
</section>
<section id="runtime-dependencies">
<h3><span class="section-number">3.10.3 </span>Runtime Dependencies<a class="headerlink" href="#runtime-dependencies" title="Permalink to this heading"></a></h3>
<p>BitBake uses the <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-PACKAGES"><span class="xref std std-term">PACKAGES</span></a>, <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RDEPENDS"><span class="xref std std-term">RDEPENDS</span></a>, and <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RRECOMMENDS"><span class="xref std std-term">RRECOMMENDS</span></a>
variables to manage runtime dependencies.</p>
<p>The <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-PACKAGES"><span class="xref std std-term">PACKAGES</span></a> variable lists runtime packages. Each of those packages
can have <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RDEPENDS"><span class="xref std std-term">RDEPENDS</span></a> and <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RRECOMMENDS"><span class="xref std std-term">RRECOMMENDS</span></a> runtime dependencies. The
<code class="docutils literal notranslate"><span class="pre">[rdeptask]</span></code> flag for tasks is used to signify the task of each item
runtime dependency which must have completed before that task can be
executed.</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">do_package_qa</span><span class="p">[</span><span class="n">rdeptask</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"do_packagedata"</span>
</pre></div>
</div>
<p>In the previous
example, the <code class="docutils literal notranslate"><span class="pre">do_packagedata</span></code> task of each item in <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RDEPENDS"><span class="xref std std-term">RDEPENDS</span></a> must
have completed before <code class="docutils literal notranslate"><span class="pre">do_package_qa</span></code> can execute.
Although <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-RDEPENDS"><span class="xref std std-term">RDEPENDS</span></a> contains entries from the
runtime dependency namespace, BitBake knows how to map them back
to the build-time dependency namespace, in which the tasks are defined.</p>
</section>
<section id="recursive-dependencies">
<h3><span class="section-number">3.10.4 </span>Recursive Dependencies<a class="headerlink" href="#recursive-dependencies" title="Permalink to this heading"></a></h3>
<p>BitBake uses the <code class="docutils literal notranslate"><span class="pre">[recrdeptask]</span></code> flag to manage recursive task
dependencies. BitBake looks through the build-time and runtime
dependencies of the current recipe, looks through the task’s inter-task
dependencies, and then adds dependencies for the listed task. Once
BitBake has accomplished this, it recursively works through the
dependencies of those tasks. Iterative passes continue until all
dependencies are discovered and added.</p>
<p>The <code class="docutils literal notranslate"><span class="pre">[recrdeptask]</span></code> flag is most commonly used in high-level recipes
that need to wait for some task to finish “globally”. For example,
<code class="docutils literal notranslate"><span class="pre">image.bbclass</span></code> has the following:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">do_rootfs</span><span class="p">[</span><span class="n">recrdeptask</span><span class="p">]</span> <span class="o">+=</span> <span class="s2">"do_packagedata"</span>
</pre></div>
</div>
<p>This statement says that the <code class="docutils literal notranslate"><span class="pre">do_packagedata</span></code> task of
the current recipe and all recipes reachable (by way of dependencies)
from the image recipe must run before the <code class="docutils literal notranslate"><span class="pre">do_rootfs</span></code> task can run.</p>
<p>BitBake allows a task to recursively depend on itself by
referencing itself in the task list:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">do_a</span><span class="p">[</span><span class="n">recrdeptask</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"do_a do_b"</span>
</pre></div>
</div>
<p>In the same way as before, this means that the <code class="docutils literal notranslate"><span class="pre">do_a</span></code>
and <code class="docutils literal notranslate"><span class="pre">do_b</span></code> tasks of the current recipe and all
recipes reachable (by way of dependencies) from the recipe
must run before the <code class="docutils literal notranslate"><span class="pre">do_a</span></code> task can run. In this
case BitBake will ignore the current recipe’s <code class="docutils literal notranslate"><span class="pre">do_a</span></code>
task circular dependency on itself.</p>
</section>
<section id="inter-task-dependencies">
<h3><span class="section-number">3.10.5 </span>Inter-Task Dependencies<a class="headerlink" href="#inter-task-dependencies" title="Permalink to this heading"></a></h3>
<p>BitBake uses the <code class="docutils literal notranslate"><span class="pre">[depends]</span></code> flag in a more generic form to manage
inter-task dependencies. This more generic form allows for
inter-dependency checks for specific tasks rather than checks for the
data in <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-DEPENDS"><span class="xref std std-term">DEPENDS</span></a>. Here is an example:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">do_patch</span><span class="p">[</span><span class="n">depends</span><span class="p">]</span> <span class="o">=</span> <span class="s2">"quilt-native:do_populate_sysroot"</span>
</pre></div>
</div>
<p>In this example, the <code class="docutils literal notranslate"><span class="pre">do_populate_sysroot</span></code> task of the target <code class="docutils literal notranslate"><span class="pre">quilt-native</span></code>
must have completed before the <code class="docutils literal notranslate"><span class="pre">do_patch</span></code> task can execute.</p>
<p>The <code class="docutils literal notranslate"><span class="pre">[rdepends]</span></code> flag works in a similar way but takes targets in the
runtime namespace instead of the build-time dependency namespace.</p>
</section>
</section>
<section id="functions-you-can-call-from-within-python">
<h2><span class="section-number">3.11 </span>Functions You Can Call From Within Python<a class="headerlink" href="#functions-you-can-call-from-within-python" title="Permalink to this heading"></a></h2>
<p>BitBake provides many functions you can call from within Python
functions. This section lists the most commonly used functions, and
mentions where to find others.</p>
<section id="functions-for-accessing-datastore-variables">
<h3><span class="section-number">3.11.1 </span>Functions for Accessing Datastore Variables<a class="headerlink" href="#functions-for-accessing-datastore-variables" title="Permalink to this heading"></a></h3>
<p>It is often necessary to access variables in the BitBake datastore using
Python functions. The BitBake datastore has an API that allows you this
access. Here is a list of available operations:</p>
<div class="wy-table-responsive"><table class="docutils align-default">
<thead>
<tr class="row-odd"><th class="head"><p><em>Operation</em></p></th>
<th class="head"><p><em>Description</em></p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><p><code class="docutils literal notranslate"><span class="pre">d.getVar("X",</span> <span class="pre">expand)</span></code></p></td>
<td><p>Returns the value of variable “X”. Using “expand=True” expands the
value. Returns “None” if the variable “X” does not exist.</p></td>
</tr>
<tr class="row-odd"><td><p><code class="docutils literal notranslate"><span class="pre">d.setVar("X",</span> <span class="pre">"value")</span></code></p></td>
<td><p>Sets the variable “X” to “value”</p></td>
</tr>
<tr class="row-even"><td><p><code class="docutils literal notranslate"><span class="pre">d.appendVar("X",</span> <span class="pre">"value")</span></code></p></td>
<td><p>Adds “value” to the end of the variable “X”. Acts like <code class="docutils literal notranslate"><span class="pre">d.setVar("X",</span>
<span class="pre">"value")</span></code> if the variable “X” does not exist.</p></td>
</tr>
<tr class="row-odd"><td><p><code class="docutils literal notranslate"><span class="pre">d.prependVar("X",</span> <span class="pre">"value")</span></code></p></td>
<td><p>Adds “value” to the start of the variable “X”. Acts like
<code class="docutils literal notranslate"><span class="pre">d.setVar("X","value")</span></code> if the variable “X” does not exist.</p></td>
</tr>
<tr class="row-even"><td><p><code class="docutils literal notranslate"><span class="pre">d.delVar("X")</span></code></p></td>
<td><p>Deletes the variable “X” from the datastore. Does nothing if the variable
“X” does not exist.</p></td>
</tr>
<tr class="row-odd"><td><p><code class="docutils literal notranslate"><span class="pre">d.renameVar("X",</span> <span class="pre">"Y")</span></code></p></td>
<td><p>Renames the variable “X” to “Y”. Does nothing if the variable “X” does
not exist.</p></td>
</tr>
<tr class="row-even"><td><p><code class="docutils literal notranslate"><span class="pre">d.getVarFlag("X",</span> <span class="pre">flag,</span> <span class="pre">expand)</span></code></p></td>
<td><p>Returns the value of variable “X”. Using “expand=True” expands the
value. Returns “None” if either the variable “X” or the named flag does
not exist.</p></td>
</tr>
<tr class="row-odd"><td><p><code class="docutils literal notranslate"><span class="pre">d.setVarFlag("X",</span> <span class="pre">flag,</span> <span class="pre">"value")</span></code></p></td>
<td><p>Sets the named flag for variable “X” to “value”.</p></td>
</tr>
<tr class="row-even"><td><p><code class="docutils literal notranslate"><span class="pre">d.appendVarFlag("X",</span> <span class="pre">flag,</span> <span class="pre">"value")</span></code></p></td>
<td><p>Appends “value” to the named flag on the variable “X”. Acts like
<code class="docutils literal notranslate"><span class="pre">d.setVarFlag("X",</span> <span class="pre">flag,</span> <span class="pre">"value")</span></code> if the named flag does not exist.</p></td>
</tr>
<tr class="row-odd"><td><p><code class="docutils literal notranslate"><span class="pre">d.prependVarFlag("X",</span> <span class="pre">flag,</span> <span class="pre">"value")</span></code></p></td>
<td><p>Prepends “value” to the named flag on the variable “X”. Acts like
<code class="docutils literal notranslate"><span class="pre">d.setVarFlag("X",</span> <span class="pre">flag,</span> <span class="pre">"value")</span></code> if the named flag does not exist.</p></td>
</tr>
<tr class="row-even"><td><p><code class="docutils literal notranslate"><span class="pre">d.delVarFlag("X",</span> <span class="pre">flag)</span></code></p></td>
<td><p>Deletes the named flag on the variable “X” from the datastore.</p></td>
</tr>
<tr class="row-odd"><td><p><code class="docutils literal notranslate"><span class="pre">d.setVarFlags("X",</span> <span class="pre">flagsdict)</span></code></p></td>
<td><p>Sets the flags specified in the <code class="docutils literal notranslate"><span class="pre">flagsdict()</span></code>
parameter. <code class="docutils literal notranslate"><span class="pre">setVarFlags</span></code> does not clear previous flags. Think of this
operation as <code class="docutils literal notranslate"><span class="pre">addVarFlags</span></code>.</p></td>
</tr>
<tr class="row-even"><td><p><code class="docutils literal notranslate"><span class="pre">d.getVarFlags("X")</span></code></p></td>
<td><p>Returns a <code class="docutils literal notranslate"><span class="pre">flagsdict</span></code> of the flags for the variable “X”. Returns “None”
if the variable “X” does not exist.</p></td>
</tr>
<tr class="row-odd"><td><p><code class="docutils literal notranslate"><span class="pre">d.delVarFlags("X")</span></code></p></td>
<td><p>Deletes all the flags for the variable “X”. Does nothing if the variable
“X” does not exist.</p></td>
</tr>
<tr class="row-even"><td><p><code class="docutils literal notranslate"><span class="pre">d.expand(expression)</span></code></p></td>
<td><p>Expands variable references in the specified string
expression. References to variables that do not exist are left as is. For
example, <code class="docutils literal notranslate"><span class="pre">d.expand("foo</span> <span class="pre">${X}")</span></code> expands to the literal string “foo
${X}” if the variable “X” does not exist.</p></td>
</tr>
</tbody>
</table></div>
</section>
<section id="other-functions">
<h3><span class="section-number">3.11.2 </span>Other Functions<a class="headerlink" href="#other-functions" title="Permalink to this heading"></a></h3>
<p>You can find many other functions that can be called from Python by
looking at the source code of the <code class="docutils literal notranslate"><span class="pre">bb</span></code> module, which is in
<code class="docutils literal notranslate"><span class="pre">bitbake/lib/bb</span></code>. For example, <code class="docutils literal notranslate"><span class="pre">bitbake/lib/bb/utils.py</span></code> includes
the commonly used functions <code class="docutils literal notranslate"><span class="pre">bb.utils.contains()</span></code> and
<code class="docutils literal notranslate"><span class="pre">bb.utils.mkdirhier()</span></code>, which come with docstrings.</p>
</section>
<section id="extending-python-library-code">
<h3><span class="section-number">3.11.3 </span>Extending Python Library Code<a class="headerlink" href="#extending-python-library-code" title="Permalink to this heading"></a></h3>
<p>If you wish to add your own Python library code (e.g. to provide
functions/classes you can use from Python functions in the metadata)
you can do so from any layer using the <code class="docutils literal notranslate"><span class="pre">addpylib</span></code> directive.
This directive is typically added to your layer configuration (
<code class="docutils literal notranslate"><span class="pre">conf/layer.conf</span></code>) although it will be handled in any <code class="docutils literal notranslate"><span class="pre">.conf</span></code> file.</p>
<p>Usage is of the form:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span><span class="n">addpylib</span> <span class="o">&lt;</span><span class="n">directory</span><span class="o">&gt;</span> <span class="o">&lt;</span><span class="n">namespace</span><span class="o">&gt;</span>
</pre></div>
</div>
<p>Where &lt;directory&gt; specifies the directory to add to the library path.
The specified &lt;namespace&gt; is imported automatically, and if the imported
module specifies an attribute named <code class="docutils literal notranslate"><span class="pre">BBIMPORTS</span></code>, that list of
sub-modules is iterated and imported too.</p>
</section>
<section id="testing-and-debugging-bitbake-python-code">
<h3><span class="section-number">3.11.4 </span>Testing and Debugging BitBake Python code<a class="headerlink" href="#testing-and-debugging-bitbake-python-code" title="Permalink to this heading"></a></h3>
<p>The OpenEmbedded build system implements a convenient <code class="docutils literal notranslate"><span class="pre">pydevshell</span></code> target which
you can use to access the BitBake datastore and experiment with your own Python
code. See <a class="reference external" href="https://docs.yoctoproject.org/dev-manual/python-development-shell.html#using-a-python-development-shell">Using a Python Development Shell</a> in the Yocto
Project manual for details.</p>
</section>
</section>
<section id="task-checksums-and-setscene">
<h2><span class="section-number">3.12 </span>Task Checksums and Setscene<a class="headerlink" href="#task-checksums-and-setscene" title="Permalink to this heading"></a></h2>
<p>BitBake uses checksums (or signatures) along with the setscene to
determine if a task needs to be run. This section describes the process.
To help understand how BitBake does this, the section assumes an
OpenEmbedded metadata-based example.</p>
<p>These checksums are stored in <a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-STAMP"><span class="xref std std-term">STAMP</span></a>. You can
examine the checksums using the following BitBake command:</p>
<div class="highlight-default notranslate"><div class="highlight"><pre><span></span>$ bitbake-dumpsigs
</pre></div>
</div>
<p>This command returns the signature data in a readable
format that allows you to examine the inputs used when the OpenEmbedded
build system generates signatures. For example, using
<code class="docutils literal notranslate"><span class="pre">bitbake-dumpsigs</span></code> allows you to examine the <code class="docutils literal notranslate"><span class="pre">do_compile</span></code> task’s
“sigdata” for a C application (e.g. <code class="docutils literal notranslate"><span class="pre">bash</span></code>). Running the command also
reveals that the “CC” variable is part of the inputs that are hashed.
Any changes to this variable would invalidate the stamp and cause the
<code class="docutils literal notranslate"><span class="pre">do_compile</span></code> task to run.</p>
<p>The following list describes related variables:</p>
<ul class="simple">
<li><p><a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BB_HASHCHECK_FUNCTION"><span class="xref std std-term">BB_HASHCHECK_FUNCTION</span></a>:
Specifies the name of the function to call during the “setscene” part
of the task’s execution in order to validate the list of task hashes.</p></li>
<li><p><a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BB_SETSCENE_DEPVALID"><span class="xref std std-term">BB_SETSCENE_DEPVALID</span></a>:
Specifies a function BitBake calls that determines whether BitBake
requires a setscene dependency to be met.</p></li>
<li><p><a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-BB_TASKHASH"><span class="xref std std-term">BB_TASKHASH</span></a>: Within an executing task,
this variable holds the hash of the task as returned by the currently
enabled signature generator.</p></li>
<li><p><a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-STAMP"><span class="xref std std-term">STAMP</span></a>: The base path to create stamp files.</p></li>
<li><p><a class="reference internal" href="bitbake-user-manual-ref-variables.html#term-STAMPCLEAN"><span class="xref std std-term">STAMPCLEAN</span></a>: Again, the base path to
create stamp files but can use wildcards for matching a range of
files for clean operations.</p></li>
</ul>
</section>
<section id="wildcard-support-in-variables">
<h2><span class="section-number">3.13 </span>Wildcard Support in Variables<a class="headerlink" href="#wildcard-support-in-variables" title="Permalink to this heading"></a></h2>
<p>Support for wildcard use in variables varies depending on the context in
which it is used. For example, some variables and filenames allow
limited use of wildcards through the “<code class="docutils literal notranslate"><span class="pre">%</span></code>” and “<code class="docutils literal notranslate"><span class="pre">*</span></code>” characters.
Other variables or names support Python’s
<a class="reference external" href="https://docs.python.org/3/library/glob.html">glob</a> syntax,
<a class="reference external" href="https://docs.python.org/3/library/fnmatch.html#module-fnmatch">fnmatch</a>
syntax, or
<a class="reference external" href="https://docs.python.org/3/library/re.html">Regular Expression (re)</a>
syntax.</p>
<p>For variables that have wildcard suport, the documentation describes
which form of wildcard, its use, and its limitations.</p>
</section>
