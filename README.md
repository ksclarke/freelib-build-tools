# freelib-build-tools &nbsp; [![Build Status](https://travis-ci.org/ksclarke/freelib-build-tools.svg?branch=master)](https://travis-ci.org/ksclarke/freelib-build-tools)

### Introduction

This project is comprised of two parts. The first part, `freelib-resources`, contains [Checkstyle](http://maven.apache.org/plugins/maven-checkstyle-plugin/) configuration files, [Code Formatter](http://help.eclipse.org/indigo/index.jsp?topic=%2Forg.eclipse.jdt.doc.user%2Freference%2Fpreferences%2Fjava%2Fcodestyle%2Fref-preferences-formatter.htm) settings for Eclipse, [JBake](http://jbake.org/) site templates, and deployment scripts for [Travis](https://travis-ci.com) builds. The second part, `freelib-parent`, contains a set of dependencies, plugins, and other configuration options to simplify the creation of new Maven projects. The second part also makes using the first's resources much easier, because it pulls them in and uses them by default when configuring a new project.

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

With these build tools, a Travis account, and a Sonatype account, it's easy to publish Jar files to Maven's Central repository. Once a project has `freelib-parent` configured as its parent, and Travis set up to do CI builds, there are just a few additional configuration steps one must take before being able to publish artifacts to Maven Central.

The first step is to create a GPG build key that can be used to sign builds.

    # Generate a new key and remember the passphrase
    gpg --gen-key
    
    # List the keys and remember the new key's ID
    gpg --list-keys
    
    # Export the private key to a file in your home directory
    gpg -a --export-secret-key [YOUR_KEY_ID] > ~/build-key.gpg
    
    # Publish your key to a public keyserver
    gpg --keyserver hkp://sks-keyservers.net --send-keys [YOUR_KEY_ID]

Once that's done, you can encrypt the key with Travis and store it in your GitHub repository's resources directory:

    cd /path/to/your/project
    
    # Have Travis encrypt your build key -- remember two variables it spits out.
    # These will look like: $encrypted_SOMETHING_key and $encrypted_SOMETHING_iv
    travis encrypt-file ~/build-key.gpg
    
    # Copy the encrypted key into your project's resources directory
    mv build-key.gpg.enc src/main/resources

Once this is done, your private key will be publicly accessible from your GitHub repository, but it will have a passphrase and also be encrypted in such a way that it can only be decrypted and read from within a Travis build.

To be able to publish your Jar file automatically from within your Travis build, you will need to add some additional Environment Variables in your Travis configuration. This can be done in the .travis.yml file, but I'd recommend doing it in Travis' online user interface.

The environmental variables that you will need to add are: `BUILD_KEYNAME`, `BUILD_PASSPHRASE`, `SONATYPE_PASSWORD`, and `SONATYPE_USERNAME`. You should make sure that all are set to NOT display their values in Travis' build log. This is an option at the point of creating these variables in the user interface and it's a **very important detail**.

The `BUILD_KEYNAME` is the GPG key ID from above. The `BUILD_PASSPHRASE` is the passphrase you created for the GPG key.

The `SONATYPE_USERNAME` and `SONATYPE_PASSWORD` are your login information for the OSS Sonatype site. These instructions will assume you are familiar with Sonatype and already using it to publish Jars in a manual fashion. If you're not, you have some more research to do before you will be able to use these instructions.

You will notice, when you are creating these environmental variables in Travis' online user interface, that at least two variables already exist. These two were shown to you when you ran `travis encrypt-file ~/build-key.gpg` command (you're supposed to be remembering them). You will not be able to see these variables' values and that's okay.

The next step you'll need to do is to configure your .travis.yml file with `before_install` and `after_success` sections. The `before_install` section should include, at least, the following:

    before_install:
      - >
        openssl aes-256-cbc -K $encrypted_SOMETHING_key -iv $encrypted_SOMETHING_iv \
          -in src/main/resources/build-key.gpg.enc -out src/main/resources/build-key.gpg -d

Notice that this contains the two outputs from the `travis encrypt-file` command (the two that you're remembering)? The SOMETHINGs above are just placeholder values. The ones you're remembering, and insert into the placeholders, will be the real values.

After the `before_install`, you'll also need to add a `after_success` section that should have, at least, the following:

    after_success:
      - src/main/tools/travis/deploy

It can also contain Codacy submission information if you're using the Codacy plugin that's defined in `freelib-parent`:

    after_success:
      - >
        mvn -q com.gavinmogan:codacy-maven-plugin:coverage -DcoverageReportFile=target/site/jacoco/jacoco.xml \
          -DprojectToken="${PROJECT_TOKEN}" -DapiToken="${API_TOKEN}"
      - >
        src/main/tools/travis/deploy

Using the Codacy submission will of course require that you have a Codacy account, that you've registered this project, and that you've configured Codacy's `API_TOKEN` and `PROJECT_TOKEN` in your project's Travis configuration.

Okay, so in summary, so far you've configured Travis to perform a deploy on a successful build, you've configured authentication and signing information in Travis' Environment Variables, and you've added a private key to your GitHub repository. So, what will happen now that you've done all this?

When Travis completes a successful build of a project that has a `*-SNAPSHOT` version, a snapshot will be deployed to Sonatype's repository. When Travis completes a successful build of a project that has been tagged with a stable version number, a stable release of the Jar artifact will be automatically uploaded to the Maven Central repository.

What we're left with needing to do is to find an easy way to handle the versioning of stable versions (and creating tags in our GitHub repository). To do this, we use two scripts that are provided in the `freelib-resources` project. These are automatically copied into the `src/main/tools/travis` directory of your project.

The first script prepares our repository for a release. We want to prepare a release from a snapshot version and we want to indicate how the version number should be incremented after our version has been minted. A version can either have its patch number, minor number, or major number incremented.

To prepare the release and increment our version, we make sure all our commits that we want in the release are pushed, and then we run:

    src/main/tools/travis/prepare_release patch

We can also run `prepare_release minor` or `prepare_release major` depending on which part of the version number we want to increment.

What does this script do? This script will change the project's snapshot version to a stable version number, make a new Git commit with this change, create a tag for this new stable version number, push that tag to GitHub, update the project's version to be a new snapshot, and commit that new snapshot version to GitHub.

The new tag being pushed to GitHub will trigger a Travis build and the `deploy` script that's been included in the .travis.yml file will do the deployment of a Jar artifact to the Maven Central repository. This process ensures that there is a tag for each version. This ensures code can be rolled back to an earlier version should there be an issue with the newly published Jar file.

To make all this work, make sure that Travis is configured to build on pushes to the master branch only once. After this, doing new stable release should just be a matter of running the `prepare_release` script. Travis will do the rest.

### Contact Information

Feel free to send any questions or comments about this project to <a href="mailto:ksclarke@ksclarke.io">Kevin S. Clarke</a>. If you notice something that is broken or that needs fixing, please submit a ticket to the project's [issues queue](https://github.com/ksclarke/freelib-build-tools/issues).
