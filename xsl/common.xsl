<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="2.0">

  <!-- import common JavaScript xsl -->
  <xsl:import href="common_js.xsl" />

  <xsl:param name="baselink" />
  <xsl:param name="title" />

    <xsl:template match="document-node()">
        <html lang="en">
          <head>
            <meta name="description" content="Harvard University Faculty of Arts and Science Course Catalog." />
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />

            <title><xsl:value-of select="$title" /></title>

            <link rel="icon" href="favicon.ico" />
            <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
            <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css" />
            <!-- style for search results table -->
            <xsl:choose>
                <xsl:when test="$title = 'Results' or $title = 'myCourses'">
                    <link rel="stylesheet" href="tables.css" />
                    <link rel="stylesheet" href="tablesorter.css" />
                </xsl:when>
                <xsl:when test="$title = 'About'">
                    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css" />
                </xsl:when>
            </xsl:choose>
            <link rel="stylesheet" href="styles.css" />

            <!--[if lt IE 9]>
              <script src="//oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
              <script src="//oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
            <![endif]-->
          </head>

          <body>
            <div class="container">
                <!-- start header -->
                <div class="header">
                    <xsl:call-template name="header" />
                </div>
                <!-- end header -->

                <!-- start nav -->
                <nav class="navbar navbar-static-top navbar-default" role="navigation">
                    <div class="navbar-header">
                      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#collapse">
                        <span>MENU</span>
                      </button>
                    </div>
                    <div class="collapse navbar-collapse" id="collapse">
                      <xsl:call-template name="nav" />
                    </div>
                </nav>
                <!-- end nav -->

              <!-- start main content -->
                <xsl:apply-templates />
              <!-- end main content -->

              <!-- start footer -->
              <footer>
                <xsl:call-template name="footer" />
              </footer>
              <!-- end footer -->
            </div>

            <!-- external scripts -->
            <xsl:call-template name="scripts" />
          </body>
        </html>
    </xsl:template>
  
  <xsl:template name="header">
    <a class="hidden-xs" href="http://www.harvard.edu/"><img src="harvard_shield2.png" alt="Harvard Shield"/></a>
      <span class="masthead hidden-xs">Harvard University, Faculty of Arts Course Catalog</span>
      <span class="visible-xs-block red_back">Harvard University <br class="hidden-desktop hidden-tablet" />Faculty of Arts<br /> Course Catalog</span>
  </xsl:template>

  <xsl:template name="nav">
      <ul class="nav navbar-nav .navbar-default">
        <li id="mnuIndex"><a href="index.html">Home</a></li>
        <li id="mnuAbout"><a href="about.html">About</a></li>
        <li id="mnuSearch"><a href="search.html">Search Courses</a></li>
        <li id="mnuContact"><a href="contact.html">Contact</a></li>
        <li id="mnuRegister"><a href="register.html">myCourses</a></li>
      </ul>
  </xsl:template>

  <xsl:template name="footer">
        <p class="copyright pull-right">&#169; Harvard University. All rights reserved.</p>
  </xsl:template>
    
  <!-- don't display XML text node data -->
  <xsl:template match="text()" />
</xsl:stylesheet>