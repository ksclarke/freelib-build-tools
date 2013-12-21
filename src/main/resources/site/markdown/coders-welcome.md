## Coders Welcome

If you're a programmer and you find a bug, or think of a feature that would be a nice addition to the project, feel free to <a href="https://github.com/ksclarke/freelib-utils">fork the project</a> and submit a pull request.

When you do (and build the project in the process), you'll probably notice that [Checkstyle](http://maven.apache.org/plugins/maven-checkstyle-plugin/) is used to validate the project's code.  Coding styles are pretty arbitrary, but they do make merging new code (and patches to existing code) easier.  To make adherence to these style guidelines easier, FreeLibrary's Java projects supply a [Checkstyle configuration for Maven](https://github.com/ksclarke/freelib-build-tools/tree/master/src/main/resources/checkstyle) and [Code Formatter settings for Eclipse](https://github.com/ksclarke/freelib-build-tools/tree/master/src/main/resources/eclipse) (as an optional convenience for those who use Eclipse).
<br/><br/>
_**Note:** Rather than create a whole new set of style guidelines, the FreeLibrary Project has adopted the Fedora Repository project's [code guidelines](https://wiki.duraspace.org/display/FF/Code+Style+Guide)._

<hr/>
_Code Style Guidelines:_
<hr/>

1. Four space indents for Java and two space indents for XML

2. No tabs

3. K & R style braces

    _For example:_

        if (code) {
          // code
        } else {
          // code
        }

4. Do not use wildcard imports

5. Write Javadocs for public methods and classes; keep them short and to the point

6. Avoid public instance variables; use accessors to provide access

7. Use public methods sparingly; implementation details should not be public

8. Maximum length of lines is 120 characters

9. Create informational Javadocs for newly created classes

    _For example:_

        /**
         * This class does this and that.
         *
         * @author <a href="mailto:jane.dev@email.com">Jane Developer</a>
         */
        public class MyClass {

## Unit Tests

One other type of pull request that is welcome is the addition of tests.  FreeLibrary projects aim to include thorough testing of their code, but sometimes fail to live up to that standard.  If you find a part of the project that would benefit from some new tests, please feel free to contribute them.  If you're adding new code, please consider writing some tests to go along with the code that you submit.  Including tests with your code ensures that the functionality you've added will continue to work over time.

## The Small Print

The FreeLibrary projects are all <a href="http://opensource.org/">open source</a> projects.  By submitting code to this project, you are asserting that you own the rights to the code and that you can legally contribute it to an open source project.  All code contributed to a FreeLibrary project is released under the license of the project.  FreeLibrary projects are small (and pretty insignificant in the larger scheme of things), but we want to state this up front so that potential contributors know what to expect.

