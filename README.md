# FreeLib-Build-Tools

This project is a collection of resources files which are imported into, and used by, other FreeLibrary projects.  Included in this bundle are [Checkstyle](http://maven.apache.org/plugins/maven-checkstyle-plugin/) configuration files, [Code Formatter](http://help.eclipse.org/indigo/index.jsp?topic=%2Forg.eclipse.jdt.doc.user%2Freference%2Fpreferences%2Fjava%2Fcodestyle%2Fref-preferences-formatter.htm) settings files for Eclipse, and site template files for projects built using the [reflow-maven-skin](http://andriusvelykis.github.io/reflow-maven-skin/).

Other projects that want to use these tools would unpack them using the [maven-dependency-plugin](http://maven.apache.org/plugins/maven-dependency-plugin/).  To do this, the other project's `pom.xml` file would include:

    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-dependency-plugin</artifactId>
      <version>2.8</version>
      <executions>
        <execution>
          <id>unpack</id>
          <phase>generate-resources</phase>
          <goals>
            <goal>unpack</goal>
          </goals>
          <configuration>
            <artifactItems>
              <!-- copies the site stylesheets into the project -->
              <artifactItem>
                <groupId>info.freelibrary</groupId>
                <artifactId>freelib-build-tools</artifactId>
                <version>${freelib.build.tools.version}</version>
                <type>jar</type>
                <includes>**/*.css,**/*.js</includes>
                <outputDirectory>${project.build.directory}</outputDirectory>
              </artifactItem>
              <!-- copies site templates into the resources directory -->
              <artifactItem>
                <groupId>info.freelibrary</groupId>
                <artifactId>freelib-build-tools</artifactId>
                <version>${freelib.build.tools.version}</version>
                <type>jar</type>
                <includes>**/*.md</includes>
                <outputDirectory>${basedir}/src/main/resources</outputDirectory>
              </artifactItem>
            </artifactItems>
          </configuration>
        </execution>
      </executions>
    </plugin>

The other project would also need to make sure the site template files were passed through a resource filter so that the name of that project would be inserted into them.  This is accomplished by including the following resource configuration in the other project:

    <resources>
      <resource>
        <directory>${basedir}/src/main/resources</directory>
        <filtering>true</filtering>
        <excludes>
          <exclude>**/*.md</exclude>
        </excludes>
      </resource>
    </resources>

The [maven-checkstyle-plugin](http://maven.apache.org/plugins/maven-checkstyle-plugin/) referenced in the other project needs to be configured to use FreeLib-Build-Tools' Checkstyle configuration.  This is done by including the following configuration in the `pom.xml`:

    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-checkstyle-plugin</artifactId>
        <version>${maven.checkstyle.version}</version>
        <dependencies>
          <dependency>
            <groupId>info.freelibrary</groupId>
            <artifactId>freelib-build-tools</artifactId>
            <version>${freelib.build.tools.version}</version>
          </dependency>
        </dependencies>
        <configuration>
          <failsOnError>true</failsOnError>
          <consoleOutput>true</consoleOutput>
          <!-- these are loaded from the freelib-build-tools jar -->
          <configLocation>checkstyle/checkstyle.xml</configLocation>
          <suppressionsLocation>checkstyle/checkstyle-suppressions.xml</suppressionsLocation>
        </configuration>
        <executions>
          <execution>
            <id>checkstyle</id>
            <phase>verify</phase>
            <goals>
              <goal>check</goal>
            </goals>
          </execution>
        </executions>
      </plugin>

You might also want to use the [maven-clean-plugin](http://maven.apache.org/plugins/maven-clean-plugin/) to clean up dynamically created build artifacts in the other project:

    <plugin>
      <artifactId>maven-clean-plugin</artifactId>
      <version>2.5</version>
      <configuration>
        <filesets>
          <fileset>
            <directory>${basedir}/src</directory>
            <includes>
              <include>**/coders-welcome.md</include>
              <include>**/testers-welcome.md</include>
              <include>**/translators-welcome.md</include>
              <include>**/documentors-welcome.md</include>
            </includes>
          </fileset>
        </filesets>
      </configuration>
    </plugin>

That's about it.  I don't know if this project will be of use to anyone else (perhaps as an example?), but it does make maintaining the different FreeLibrary projects much easier.

### Contact Information

Feel free to send any questions or comments to Kevin S. Clarke at ksclarke@gmail.com