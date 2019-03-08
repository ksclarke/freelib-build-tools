# freelib-build-tools &nbsp; [![Build Status](https://travis-ci.org/ksclarke/freelib-build-tools.svg?branch=master)](https://travis-ci.org/ksclarke/freelib-build-tools)

### Introduction

This project is comprised of two parts. The first part is a collection of resources which can be imported into, and used by, other projects. The second part is a parent project which can be used to simplify the configuration of projects which inherit from it.

### Details

Included in the first part, `freelib-resources`, are [Checkstyle](http://maven.apache.org/plugins/maven-checkstyle-plugin/) configuration files, [Code Formatter](http://help.eclipse.org/indigo/index.jsp?topic=%2Forg.eclipse.jdt.doc.user%2Freference%2Fpreferences%2Fjava%2Fcodestyle%2Fref-preferences-formatter.htm) settings files for Eclipse, [JBake](http://jbake.org/) site template files, and scripts for [Travis](https://travis-ci.com) builds. Included in the second part, `freelib-parent`, are a standard set of dependencies, plugins, and other configuration options to simplify the creation of new Maven projects.

Projects wanting to take advantage of `freelib-build-tools`' simplified configuration can configure `freelib-parent` as their project's parent. To do this, add the following to the bottom of a project's pom.xml file (inside the POM file's existing root element, of course):

    <parent>
      <groupId>info.freelibrary</groupId>
      <artifactId>freelib-parent</artifactId>
      <version>${freelib.tools.version}</version>
    </parent>

When this is done, the resources in `freelib-resources` will also be available to the inheriting project because it's used in the `freelib-parent` POM.

To see a simple example project that uses `freelib-build-tools` see [freelib-utils](https://github.com/ksclarke/freelib-utils).

### Deploying with freelib-build-tools

With these build tools, a Travis account, and a Sonatype account, it's easy to publish Jar files to Maven's Central repository. Once a project has `freelib-parent` configured as its parent and Travis set up to do CI builds, there are just a few additional configuration steps one must take before being able to use two simple scripts from this project to publish to Maven Central.

The first step is to create a GPG build key that can be used to sign builds.

    # Generate a new key and remember the passphrase
    gpg --gen-key
    
    # List the keys and remember the new key's ID
    gpg --list-keys
    
    # Export the private key to a file in your home directory
    gpg -a --export-secret-key [YOUR_KEY_ID] > ~/build-key.gpg
    
    # Publish your key to a public keyserver
    gpg --keyserver hkp://sks-keyservers.net --send-keys [YOUR_KEY_ID]

Once that's done, you can encrypt the key with Travis and store it in your GitHub repository in your resources directory:

    cd /path/to/your/project
    
    # Have Travis encrypt your build key and remember two variables it spits out.
    # These will look like: $encrypted_SOMETHING_key and $encrypted_SOMETHING_iv
    travis encrypt-file ~/build-key.gpg

    mv build-key.gpg.enc src/main/resources

Once this is done, your private key will be accessible from your GitHub repository, but it will have a passphrase and be encrypted in such a way that it can only be decrypted and read from within a Travis build.

To be able to publish your Jar file automatically from within your Travis build, you will also need to add some additional Environment Variables in your Travis online configuration. This can be done in the .travis.yml file, but I'd recommend doing it in Travis' online user interface.

The environmental variables that you will need to add are: `BUILD_KEYNAME`, `BUILD_PASSPHRASE`, `SONATYPE_PASSWORD`, and `SONATYPE_USERNAME`. You should make sure that all are set to NOT display their values in Travis' build log. This is an option at the point of creating these variables in the user interface and it's a **very important detail**.

The `BUILD_KEYNAME` is the GPG key ID from above. The `BUILD_PASSPHRASE` is the passphrase you created for the GPG key.

The `SONATYPE_USERNAME` and `SONATYPE_PASSWORD` are your login information for the OSS Sonatype site. These instructions will assume you are familiar with Sonatype and already using it to publish Jars in a manual fashion. If you're not, you have some more research to do before you will be able to use these instructions.

You will notice, when you are creating these environmental variables in Travis' online user interface, that at least two already exist. These two were shown to you when you ran `travis encrypt-file ~/build-key.gpg` command (you're supposed to be remembering them). You will not be able to see these variables' values and that's okay.

The next step you'll need to take is to configure your .travis.yml file with `before_install` and `after_success` sections. The `before_install` section should include, at least, the following:

    before_install:
      - >
        openssl aes-256-cbc -K $encrypted_SOMETHING_key -iv $encrypted_SOMETHING_iv \
          -in src/main/resources/build-key.gpg.enc -out src/main/resources/build-key.gpg -d

Notice that this contains the two outputs from the `travis encrypt-file` command (that you're remembering). After the `before_install`, you'll also need to add a `after_success` section that should have, at least, the following:

    after_success:
      - src/main/tools/travis/deploy

It can also contain Codacy submission information if you're using the Codacy plugin that's defined in `freelib-parent`:

    after_success:
      - >
        mvn -q com.gavinmogan:codacy-maven-plugin:coverage -DcoverageReportFile=target/site/jacoco/jacoco.xml \
          -DprojectToken="${PROJECT_TOKEN}" -DapiToken="${API_TOKEN}"
      - >
        src/main/tools/travis/deploy

Using the Codacy submission will of course require that you have a Codacy account, that you've registered this project, and that you've configured Codacy's `API_TOKEN` and `PROJECT_TOKEN` in your project's Travis Environment Variables online, through the user interface, or in your .travis.yml file.

Okay, so in summary, so far you've configured Travis to perform a deploy on a successful build, you've configured authentication and signing information in Travis' Environment Variables, and you've added a signing key to your GitHub repository. So, what will happen now that you've done this?

When Travis completes a successful build of a project that has a `*-SNAPSHOT` version, a snapshot will be deployed to Sonatype's repository. When Travis completes a successful build of a project that has been tagged with a stable version number, a stable release of the Jar artifact will be uploaded to the Maven Central repository.

What we're left with is an easy way to handle the versioning of stable versions (and creating tags in our GitHub repository). To do this, we use two scripts that are provided in the `freelib-resources` project.

The first script prepares our repository for a release. We want to prepare a release from a snapshot version and we want to indicate how the version number should be incremented after our version has been minted. A version can either have its patch number, minor number, or major number incremented.

To prepare the release and increment our version, we make sure all our commits that we want in the release are pushed and then run:

    src/main/tools/travis/prepare_release patch # or 'minor' or 'major'

This will change the snapshot version to a stable version number, make a Git commit with this new change, create a tag for this new stable version number, push that tag to GitHub, increment the version to a new snapshot version, and commit that snapshot version to GitHub.

The new tag being pushed to GitHub will trigger a new Travis build and the deploy script that's been included in the .travis.yml file will do the deployment of a Jar artifact to the Maven Central repository. This ensures there is always a tag for a new version so that code can be rolled back to an earlier version should there be an issue with the new Jar file.

To make all this work, make sure that Travis is configured to build on pushes to the master branch only once (sometimes certain GitHub/Travis integrations want to build more than once for a push to master). Once this is all configured for a project, doing new stable releases should just be a matter of running the `prepare_release` script.

### Contact Information

Feel free to send any questions or comments about this project to <a href="mailto:ksclarke@ksclarke.io">Kevin S. Clarke</a>.
