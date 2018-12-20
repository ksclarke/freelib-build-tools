		</div>
		<div id="push"></div>
    </div>
    
    <div id="footer">
      <div class="container">
        <table width="100%"><tr>
          <td style="text-align: left;" class="muted credit">&copy; 2015 <a href="http://www.gnu.org/licenses/fdl-1.3-standalone.html">GNU Free Documentation License</a></td>
          <td colspan="2"/>
          <td style="text-align: right;">Mixed with <a href="http://getbootstrap.com/">Bootstrap</a> | Baked with <a href="http://jbake.org">JBake</a> | Served with <a href="https://github.com/ingenieux/jbake-maven-plugin">jbake-maven-plugin</a></td>
        </tr></table>
      </div>
    </div>

    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>js/jquery-1.11.1.min.js"></script>
    <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>js/bootstrap.min.js"></script>
    <script type="text/javascript">\$(document).ready(function(){ \$('[data-toggle="tooltip"]').tooltip(); });</script>
    <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>js/prettify.js"></script>
    
  </body>
</html>