<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="2.0"
                xmlns:courses="http://www.harvard.edu/courses">

  <xsl:output
      method="xml"
      encoding="utf-8"
      omit-xml-declaration="yes"
      doctype-public="http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd"
      doctype-system="-//W3C//DTD XHTML Basic 1.1//EN" />

  <!-- params to hold values from search form -->
  <!--
    if the user has not made a selection for the following,
    use the default values in the search.
  -->
  <xsl:param name="departments" />    <!-- default = All -->
  <xsl:param name="course_groups" />  <!-- default = All -->
  <xsl:param name="meeting_day" />    <!-- 1 = Mon -->
  <xsl:param name="begin_time" />     <!-- default = All -->
  <!--
    the following must be entered / selected by the user on the search form.
    if they have no value, or are not present in the querystring, do not
    use them in the search.
  -->
  <xsl:param name="instructor_name" />
  <xsl:variable name="instructor_name_normalized" select="normalize-space($instructor_name)" />
  <xsl:param name="spring_term" />
  <xsl:param name="fall_term" />
  <xsl:param name="search_text" />
  <xsl:variable name="search_text_normalized" select="normalize-space($search_text)" />

  <xsl:param name="querystring" />

  <xsl:variable name="meeting_day_seq" as="item()*">
    <xsl:analyze-string select="$querystring" regex="meeting_day=([^&amp;]*)">
      <xsl:matching-substring>
        <xsl:sequence select="regex-group(1)"/>
      </xsl:matching-substring>
    </xsl:analyze-string>
  </xsl:variable>
</xsl:stylesheet>