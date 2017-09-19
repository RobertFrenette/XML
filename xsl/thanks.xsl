<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="2.0">

  <!-- import common page layout -->
  <xsl:import href="common.xsl" />

  <xsl:param name="name" />
  <xsl:param name="email" />
  <xsl:param name="phone" />
  <xsl:param name="question" />


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
  <xsl:template match="courses">
      <div class="row">
        <h2 class="contact">Thanks for your message, <xsl:value-of select="$name" />.</h2>
        <p class="contact">Note: This page is for demonstration purposes only.</p>
        <p class="contact"><span class="strong">Email: </span> <xsl:value-of select="$email" /></p>
        <p class="contact"><span class="strong">Phone: </span> <xsl:value-of select="$phone" /></p>
        <p class="contact"><span class="strong">Question: </span> <xsl:value-of select="$question" /></p>
      </div>
  </xsl:template>
</xsl:stylesheet>