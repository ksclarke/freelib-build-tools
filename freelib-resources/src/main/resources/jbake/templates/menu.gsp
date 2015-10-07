	<!-- Fixed navbar -->
    <div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="http://projects.freelibrary.info"
          data-toggle="tooltip" data-placement="bottom" data-original-title="Find other FreeLibrary projects">FreeLibrary Projects</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>index.html" data-toggle="tooltip"
            data-placement="bottom" data-original-title="Return to project's home page">${config.project_name}</a> </li>
            <li><a href="http://github.com/ksclarke/${config.project_name.toLowerCase()}" target="_blank"
            data-toggle="tooltip" data-placement="bottom" data-original-title="View project's source code">GitHub↗</a></li>
            <li><a href="http://github.com/ksclarke/${config.project_name.toLowerCase()}/releases" target="_blank"
            data-toggle="tooltip" data-placement="bottom" data-original-title="Download a stable release">Releases↗</a></li>
            <li><a href="http://sonar.freelibrary.info/dashboard/index/info.freelibrary:${config.project_name.toLowerCase()}"
            target="_blank" data-toggle="tooltip" data-placement="bottom"
            data-original-title="View Sonar&apos;s code metrics">Metrics↗</a></li>
            <li><a href="https://travis-ci.org/ksclarke/${config.project_name.toLowerCase()}" target="_blank"
            data-toggle="tooltip" data-placement="bottom" data-original-title="View Travis builds">CI↗</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Docs <b class="caret"></b></a>
              <ul class="dropdown-menu"><%
                for (index in config.project_docs.tokenize( '|' )) { %>
                  <li><a href="${index.toLowerCase()}.html">${index}</a></li>
                <% } %>
                <li><a href="javadocs.html">Javadocs</a></li>
                <li><a href="https://raw.githubusercontent.com/ksclarke/${config.project_name.toLowerCase()}/master/LICENSE.txt"
                target="_blank">License↗</a></li>
                <li class="divider"></li>
                <li><a href="http://github.com/ksclarke/${config.project_name.toLowerCase()}/issues"
                target="_blank">Issues Queue↗</a></li>
                <li><a href="https://groups.google.com/forum/#!forum/freelibrary-projects" target="_blank">Mailing List↗</a></li>
              </ul>
            </li>
            <li><a href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>${config.feed_file}" target="_blank"
              data-toggle="tooltip" data-placement="bottom" data-original-title="Subscribe to project updates">
              <img style="margin: 0px;" width="70%" height="70%" src="images/rss.png"/></a></li>
          </ul>
        </div>
      </div>
    </div>
    <div class="container">