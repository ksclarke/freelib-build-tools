# FreeLib-Build-Tools

This project is a collection of resources files which are imported into, and used by, other FreeLibrary projects.  Included in this bundle are [Checkstyle](http://maven.apache.org/plugins/maven-checkstyle-plugin/) configuration files, [Code Formatter](http://help.eclipse.org/indigo/index.jsp?topic=%2Forg.eclipse.jdt.doc.user%2Freference%2Fpreferences%2Fjava%2Fcodestyle%2Fref-preferences-formatter.htm) settings files for Eclipse, and site template files for FreeLibrary projects built using the [reflow-maven-skin](http://andriusvelykis.github.io/reflow-maven-skin/).

Other projects that want to use these tools can unpack them using the [maven-dependency-plugin](http://maven.apache.org/plugins/maven-dependency-plugin/).  They just need to include the following configuration in the pom.xml file:

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
              <!-- copies checkstyle configs so we can filter them -->
              <artifactItem>
                <groupId>info.freelibrary</groupId>
                <artifactId>freelib-build-tools</artifactId>
                <version>${freelib.build.tools.version}</version>
                <type>jar</type>
                <includes>checkstyle/*.xml</includes>
                <outputDirectory>${basedir}/src/main/resources</outputDirectory>
              </artifactItem>
            </artifactItems>
          </configuration>
        </execution>
      </executions>
    </plugin>

The other project also needs to ensure that the site template files are passed through a resource filter (so that that project's name is inserted into them).  This is accomplished through the following resource configuration:

    <resources>
      <!-- site's markdown template resources -->
      <resource>
        <directory>${basedir}/src/main/resources</directory>
        <filtering>true</filtering>
        <includes>
          <include>**/*.md</include>
        </includes>
        <targetPath>${basedir}/src</targetPath>
      </resource>
      <!-- normal types of project resources -->
      <resource>
        <directory>${basedir}/src/main/resources</directory>
        <filtering>true</filtering>
        <excludes>
          <exclude>**/*.md</exclude>
        </excludes>
      </resource>
    </resources>

The [maven-checkstyle-plugin](http://maven.apache.org/plugins/maven-checkstyle-plugin/) referenced in the other project needs to be configured to use FreeLib-Build-Tools' Checkstyle configuration.  This is done by including the following configuration in the other project's pom.xml file:

    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-checkstyle-plugin</artifactId>
        <version>${maven.checkstyle.version}</version>
        <configuration>
          <consoleOutput>true</consoleOutput>
          <configLocation>${basedir}/target/classes/checkstyle/checkstyle.xml</configLocation>
        </configuration>
        <!-- add the newer checkstyle with throwsIndent support -->
        <dependency>
          <groupId>com.puppycrawl.tools</groupId>
          <artifactId>checkstyle</artifactId>
          <version>5.7</version>
        </dependency>
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

Using the [maven-clean-plugin](http://maven.apache.org/plugins/maven-clean-plugin/) will help clean up dynamically created build artifacts in the other project:

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
          <fileset>
            <directory>${basedir}/src/main/resources/checkstyle</directory>
          </fileset>
        </filesets>
      </configuration>
    </plugin>

Finally, the following property will need to be included in the pom.xml's properties configuration:

    <properties>
      <!-- used for finding the unpacked checkstyle-suppressions.xml file -->
      <!-- built-in for eclipse-cs tool so we make it work with maven too -->
      <config_loc>${project.basedir}/target/classes/checkstyle</config_loc>
    </properties>

That's about it.  I don't know if this project will be of use to anyone else (perhaps as an example?), but it does make maintaining the different FreeLibrary projects much easier.

### Contact Information

Feel free to send any questions or comments to Kevin S. Clarke at ksclarke@gmail.com
