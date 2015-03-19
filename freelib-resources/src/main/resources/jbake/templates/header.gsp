<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <title><%if (content.title) {%>${content.title}<% } else { %>JBake<% }%></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="FreeLibrary Projects">
    <meta name="author" content="Kevin S. Clarke">
    <meta name="keywords" content="<%if (config.project_keywords) {%>${config.project_keywords.join(', ')}<% } else { %><% }%>">
    <meta name="generator" content="JBake">

    <!-- Le styles -->
    <link href='http://fonts.googleapis.com/css?family=Cabin:400,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Droid+Sans+Mono' rel='stylesheet' type='text/css'>
    <link href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>css/bootstrap.min.css" rel="stylesheet">
    <link href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>css/style.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>js/html5shiv.min.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <!--<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">-->
    <link rel="shortcut icon" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>favicon.ico">
    
    <% if (content.title == "javadocs") { %>
      <!-- Copied from Javadoc output -->
      <script type="text/javascript">
        targetPage = '' + window.location.search;
        if (targetPage != '' && targetPage != "undefined")
          targetPage = targetPage.substring(1);
        if (targetPage.indexOf(":") != -1 || (targetPage != "" && !validURL(targetPage)))
          targetPage = "undefined";
        function validURL(url) {
          try {
            url = decodeURIComponent(url);
          }
          catch (error) {
            return false;
          }
          var pos = url.indexOf(".html");
          if (pos == -1 || pos != url.length - 5)
            return false;
          var allowNumber = false;
          var allowSep = false;
          var seenDot = false;
          for (var i = 0; i < url.length - 5; i++) {
            var ch = url.charAt(i);
            if ('a' <= ch && ch <= 'z' || 'A' <= ch && ch <= 'Z' || ch == '\$' || ch == '_' || ch.charCodeAt(0) > 127) {
                allowNumber = true;
                allowSep = true;
            } else if ('0' <= ch && ch <= '9' || ch == '-') {
                if (!allowNumber)
                     return false;
            } else if (ch == '/' || ch == '.') {
                if (!allowSep)
                    return false;
                allowNumber = false;
                allowSep = false;
                if (ch == '.')
                     seenDot = true;
                if (ch == '/' && seenDot)
                     return false;
            } else {
                return false;
            }
          }
          return true;
        }
        function loadFrames() {
          if (targetPage != "" && targetPage != "undefined")
            top.classFrame.location = top.targetPage;
        }
      </script>
    <% } %>

  </head>
  <body>
    <div id="wrap">
   