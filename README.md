# FreeLib-Build-Tools

This project is a collection of resources files which are imported into and used by other FreeLibrary projects.  Included in the bundle are Checkstyle configuration files, Code Formatter settings files for Eclipse, and site template files for FreeLibrary projects.

Another project that wants to use these build tools would unpack the tools using the `maven-dependency-plugin`; to do this, the other project's pom.xml file would include:

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

The other project would also need to make sure the site template files were passed through a resource filter so that the name of that project would be inserted into the site's templates.  This is accomplished by including the following resource configuration in the other project:

    <resources>
      <resource>
        <directory>${basedir}/src/main/resources</directory>
        <filtering>true</filtering>
        <excludes>
          <exclude>**/*.md</exclude>
        </excludes>
      </resource>
    </resources>

Lastly, the `maven-checkstyle-plugin` would need to be configured to use the Checkstyle configuration files included in the FreeLib-Build-Tools jar.  This is done by including and configuring the `maven-checkstyle-plugin`:

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

That's about it.  I don't know if this project if of use to anyone else, but it makes maintaining different FreeLibrary projects much easier.

### Contact

Feel free to send any questions to Kevin S. Clarke at ksclarke@gmail.com