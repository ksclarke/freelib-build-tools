# FreeLib-Build-Tools

This project is a collection of resources which are imported into, and used by, other FreeLibrary projects.  Included are [Checkstyle](http://maven.apache.org/plugins/maven-checkstyle-plugin/) configuration files, [Code Formatter](http://help.eclipse.org/indigo/index.jsp?topic=%2Forg.eclipse.jdt.doc.user%2Freference%2Fpreferences%2Fjava%2Fcodestyle%2Fref-preferences-formatter.htm) settings files for Eclipse, a core set of dependencies, and [JBake](http://jbake.org/) site template files.

Projects that want to take advantage of these resources (probably just other FreeLibrary projects) can configure this project as their parent in their `pom.xml` file. For instance:

<script>
xmlhttp=new XMLHttpRequest();
xmlhttp.open("GET", "http://freelibrary.info/mvnlookup.php?project=freelib-build-tools", false);
xmlhttp.send();
$version = xmlhttp.responseText;
</script>

<pre><code>&lt;parent&gt;
  &lt;groupId&gt;info.freelibrary&lt;/groupId&gt;
  &lt;artifactId&gt;freelib-marc4j&lt;/artifactId&gt;
  &lt;version&gt;<script>document.write($version);</script><noscript>${version}</noscript>&lt;/version&gt;
&lt;/parent&gt;
</code></pre>

### Contact Information

Feel free to send any questions or comments to Kevin S. Clarke at ksclarke@gmail.com
