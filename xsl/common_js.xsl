<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="2.0">

  <xsl:template name="scripts">
    <script src="//code.jquery.com/jquery-1.11.1.min.js"><xsl:text> </xsl:text></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"><xsl:text> </xsl:text></script>
    <xsl:choose>
        <xsl:when test="$title = 'Home'">
            <script src="index.js" type="text/javascript"><xsl:text> </xsl:text></script>
        </xsl:when>
        <xsl:when test="$title = 'About'">
            <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"><xsl:text> </xsl:text></script>
            <script src="about.js" type="text/javascript"><xsl:text> </xsl:text></script>
        </xsl:when>
        <xsl:when test="$title = 'Contact'">
            <script src="contact.js" type="text/javascript"><xsl:text> </xsl:text></script>
        </xsl:when>
        <xsl:when test="$title = 'Search'">
            <script src="search.js" type="text/javascript"><xsl:text> </xsl:text></script>
        </xsl:when>
        <xsl:when test="$title = 'Results'">
            <script src="jquery.tablesorter.min.js" type="text/javascript"><xsl:text> </xsl:text></script>
            <script src="search_results.js" type="text/javascript"><xsl:text> </xsl:text></script>
        </xsl:when>
        <xsl:when test="$title = 'Course'">
            <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"><xsl:text> </xsl:text></script>
            <script src="map.js" type="text/javascript"><xsl:text> </xsl:text></script>
            <script src="modernizr-2-7-1.js" type="text/javascript"><xsl:text> </xsl:text></script>
            <script src="persist.js" type="text/javascript"><xsl:text> </xsl:text></script>
            <script src="course_detail.js" type="text/javascript"><xsl:text> </xsl:text></script>
        </xsl:when>
        <xsl:when test="$title = 'myCourses'">
            <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"><xsl:text> </xsl:text></script>
            <script src="jquery.tablesorter.min.js" type="text/javascript"><xsl:text> </xsl:text></script>
            <script src="map.js" type="text/javascript"><xsl:text> </xsl:text></script>
            <script src="modernizr-2-7-1.js" type="text/javascript"><xsl:text> </xsl:text></script>
            <script src="persist.js" type="text/javascript"><xsl:text> </xsl:text></script>
            <script src="register.js" type="text/javascript"><xsl:text> </xsl:text></script>
        </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>