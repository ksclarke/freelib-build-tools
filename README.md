# freelib-build-tools

![Maven Build](https://github.com/ksclarke/freelib-build-tools/workflows/Maven%20Build/badge.svg)

### Introduction

This project is comprised of two parts. The first part, `freelib-resources`, contains [Checkstyle](http://maven.apache.org/plugins/maven-checkstyle-plugin/) configuration files, Code Formatter settings for Eclipse, PMD rules, etc. The second part, `freelib-parent`, contains a set of dependencies, plugins, and other configuration options to simplify the creation of new Maven projects. The second part also makes using the first's resources much easier because it pulls them in and uses them by default when a new project is configured.

### Using this project

Projects wanting to take advantage of `freelib-build-tools`' simplified configuration can configure `freelib-parent` as their project's parent. To do this, add the following as the last element in the POM's root element:

    <parent>
      <groupId>info.freelibrary</groupId>
      <artifactId>freelib-parent</artifactId>
      <version>${freelib.tools.version}</version>
    </parent>

Once this is done, all the configuration options in `freelib-parent`, including the resources from `freelib-resources`, will be available to your project. You can add them by simply referencing the plugins, etc., defined in the parent project. To see an example of how to use `freelib-build-tools` see [freelib-utils](https://github.com/ksclarke/freelib-utils)'s POM file.

Note that freelib-build-tools is primarily intended for FreeLibrary projects so things like the site templates may not be generally useful to other projects. Even if you do not use freelib-build-tools directly, there may be some tricks, tools, and conventions here that will be useful in the creation of your own build tools project.

### Deploying with freelib-build-tools

With these build tools and a Sonatype account, it's easy to publish Jar files to Maven's Central repository. Once a project has `freelib-parent` configured as its parent, there are just a few additional configuration steps one must take before being able to publish artifacts to Maven Central.

The first step is to create a GPG build key that can be used to sign builds.

    # Generate a new key and remember the passphrase
    gpg --gen-key
    
    # List the keys and remember the new key's ID
    gpg --list-keys
    
    # Export the private key to a file in your home directory
    gpg -a --export-secret-key [YOUR_KEY_ID] > ~/build-key.gpg
    
    # Publish your key to a public keyserver
    gpg --keyserver hkp://sks-keyservers.net --send-keys [YOUR_KEY_ID]

Once that's done, you can encrypt they private key so that it can be used in a CI system. How you do that will depend on the CI system that you're using. Whichever system you use, there are some basic environmental variables that will need to be set so that you can use the features in this project.

The environmental variables that you will need to add are: `BUILD_KEYNAME`, `BUILD_PASSPHRASE`, `CODACY_API_TOKEN`, `CODACY_PROJECT_TOKEN`, `SONATYPE_PASSWORD`, and `SONATYPE_USERNAME`.

The `BUILD_KEYNAME` is the GPG key ID from above. The `BUILD_PASSPHRASE` is the passphrase you created for the GPG key.

The `CODACY_PROJECT_TOKEN` and `CODACY_API_TOKEN` variables are used to send code coverage reports to [Codacy](https://codacy.com). You need to create a Codacy account and add a project before you'll have those values.

The `SONATYPE_USERNAME` and `SONATYPE_PASSWORD` are your login information for the OSS Sonatype site.

All these variables can be used with a CI platform to configure builds and automated code reviews to happen automatically.

### Contact Information

If you notice something that is broken or that needs fixing, please submit a ticket to the project's [issues queue](https://github.com/ksclarke/freelib-build-tools/issues). If you have a question or a general comment about the project, please use the project's [discussion board](https://github.com/ksclarke/jiiify-presentation/discussions).

Thanks for your interest in this project!
