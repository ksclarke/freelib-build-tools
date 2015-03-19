<%include "header.gsp"%>
	<%include "menu.gsp"%>
	
    <% if (content.title == "javadocs") { %>
      <script>
        var height = window.innerHeight || html.clientHeight  || body.clientHeight  || screen.availHeight;
        document.write('<iframe id="javadocs" src="apidocs/index.html" width="100%" seamless="seamless" ');
        document.write('height="' + (height - 125) + 'px"></iframe>');
      </script>
      <noscript>
        <iframe id="javadocs" src="apidocs/index.html" width="100%" seamless="seamless" height="600px"></iframe>
      </noscript>
    <% } else { %>
      <div class="page-header">
        <h1>${content.title}</h1>
      </div>
      <p>${content.body}</p>
      <hr />
    <% } %>

<%include "footer.gsp"%>