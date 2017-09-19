<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  version="2.0">

   <!-- import common page layout -->
  <xsl:import href="common.xsl" />
  
    <xsl:output
        method="xml"
        encoding="utf-8"
        omit-xml-declaration="yes"
        doctype-public="http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd"
        doctype-system="-//W3C//DTD XHTML Basic 1.1//EN" />

    <!--
      match on courses, since the following was set in common.xsl:
      <xsl:template match="document-node()">
    -->
  <xsl:template match="/featured_courses">
    <div class="student_life">
      <div class="row">
          <xsl:for-each select="course">
              <!--<div class="col-lg-4 hidden-xs">-->
              <div class="col-lg-4 featured_course_div">
                  <h2 class="featured">Featured Course:</h2>
                  <h2><xsl:value-of select="./title" /></h2>
                  <h3><xsl:value-of select="concat(./department,' ', course_num)" /></h3>
                  <xsl:variable name="url"><xsl:value-of select="concat('course_detail.html?cat_num=', ./@cat_num, '&#38;building=', ./building, '&#38;no_nav=true')"/></xsl:variable>
                  <p class="line-clamp"><xsl:value-of select="substring(./desc, 1, 300)" /> ... <a href="{replace($url, ' ', '%20')}">View More</a></p>
              </div>
          </xsl:for-each>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>