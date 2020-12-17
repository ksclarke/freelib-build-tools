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

Note that freelib-build-tools is primarily intended for FreeLibrary projects so some things may not be generally useful to other projects. Even if you do not use freelib-build-tools directly, there may be some tricks, tools, and conventions here that will be useful in the creation of your own build tools project.

### Deploying with freelib-build-tools

This project now uses the [action-maven-publish](https://github.com/marketplace/actions/action-maven-publish) GitHub Action. When I switched from using Travis to GitHub Actions, I found this Action, and since it does everything my bespoke release scripts were doing, I dumped my scripts and started using it instead. The Action's author has a [Deployment Setup](https://github.com/samuelmeuli/action-maven-publish/blob/master/docs/deployment-setup.md) guide that you can use to take advantage of this project's Action configurations if you want. A build of a project that extends freelib-build-tools will check out a series of GitHub Actions into a new project's `.github` directory, creating it if necessary. Currently, this process overwrites any existing Action files. So, keep that in mind before you start using freelib-build-tools.

### Contact Information

If you notice something that is broken or that needs fixing, please submit a ticket to the project's [issues queue](https://github.com/ksclarke/freelib-build-tools/issues). If you have a question or a general comment about the project, please use the project's [discussion board](https://github.com/ksclarke/jiiify-presentation/discussions).

Thanks for your interest in this project!
