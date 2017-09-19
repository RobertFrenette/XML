<xsl:stylesheet 
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:param name="department" />

  <xsl:template match="/">
      <xsl:text>{"course_groups":[</xsl:text>
	<xsl:apply-templates match="courses" />
      <xsl:text>]}</xsl:text>
  </xsl:template>  
  
  <xsl:template match="courses">
    <xsl:for-each-group select="course/department[@code eq $department]" group-by="../course_group">
      <xsl:sort select="current-grouping-key()" />
        {"course_group":"<xsl:value-of select="current-grouping-key()" />",
          "code":"<xsl:value-of select="../course_group/@code" />"
        }<xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
    </xsl:for-each-group>
  </xsl:template>

  <xsl:template match="text()" />
</xsl:stylesheet>
