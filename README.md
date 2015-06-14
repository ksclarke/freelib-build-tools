# FreeLib-Build-Tools

This project is a collection of resources which are imported into, and used by, other projects.  Included are [Checkstyle](http://maven.apache.org/plugins/maven-checkstyle-plugin/) configuration files, [Code Formatter](http://help.eclipse.org/indigo/index.jsp?topic=%2Forg.eclipse.jdt.doc.user%2Freference%2Fpreferences%2Fjava%2Fcodestyle%2Fref-preferences-formatter.htm) settings files for Eclipse, a core set of dependencies, and [JBake](http://jbake.org/) site template files.

Projects that want to take advantage of these resources (probably just other FreeLibrary projects) can configure this project as their parent in their `pom.xml` file. For instance:

    <parent>
      <groupId>info.freelibrary</groupId>
      <artifactId>freelib-build-tools</artifactId>
      <version>${buildtools.version}</version>
    </parent>

### Contact Information

Feel free to send any questions or comments about this project to Kevin S. Clarke (ksclarke@gmail.com)
