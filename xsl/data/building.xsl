<xsl:stylesheet 
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:param name="building" />

  <xsl:template match="/">
      <xsl:text>{"building":[</xsl:text>
	    <xsl:apply-templates match="buildings" />
      <xsl:text>]}</xsl:text>
  </xsl:template>  
  
  <xsl:template match="buildings">
      <xsl:apply-templates match="building" />
  </xsl:template>
  
  <xsl:template match="building">
      <xsl:if test="name = $building">
	    {
		  "lat":"<xsl:value-of select="latitude" />",
		  "lng":"<xsl:value-of select="longitude" />"
	    }
      </xsl:if>
  </xsl:template>

  <xsl:template match="text()" />
</xsl:stylesheet>