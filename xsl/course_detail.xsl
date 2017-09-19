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

    <!-- param to store courses/@cat_num.html passed in querystring -->
    <xsl:param name="cat_num" />
    <xsl:param name="no_nav" />
  
    <!-- varaible to hold specific course -->
    <xsl:variable name="theCourse" select="/courses/course[@cat_num eq $cat_num]" />

  <!--
    match on courses, since the following was set in common.xsl:
    <xsl:template match="document-node()">
  -->
  <xsl:template match="courses">
    <!-- TBD: Get dynamic content course.xml -->
    <div class="row">
        <div class="col-lg-12">
                <xsl:if test="$no_nav != 'true'">
                <div class="breadcrumb-nav main-breadcrumb-nav hidden-sm hidden-xs">
                  <ul>
                    <li><a href="{$baselink}search.html">Search Courses</a>
                      <ul>
                        <li><a href="#" id="hrefResults">Search Results</a>
                          <ul>
                            <li><xsl:value-of select="$theCourse/title" /></li>
                          </ul>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </div>
            </xsl:if>

            <button class="btn btn-primary pull-right" id="btnReg">Save</button>
            <br />
            <h2 id="courseStatus">
              <xsl:if test="$theCourse/@offered = 'N'">[ </xsl:if>
              <xsl:value-of select="$theCourse/title" />
              <xsl:if test="$theCourse/@offered = 'N'"> ]</xsl:if>
            </h2>
            <h3 id="courseTitle">
                <xsl:value-of select="concat($theCourse/course_group, ' ', $theCourse/course_number/num_int, '. ', $theCourse/title)" />
                <span id="pdf-logo" class="pull-right">
                  <a href="course_detail.pdf?cat_num={$cat_num}"><img src="pdf-logo.gif" class="pdf-logo hidden-xs hidden-sm hidden-md" alt="PDF" /></a>
                </span>
            </h3>
            <div>Catalog Number: <span id="courseCatNbr">&#160;<xsl:value-of select="$cat_num" /></span></div>
            <div class="course-div faculty">&#160;<xsl:value-of select="$theCourse/faculty_text" /></div>
            <div class="course-div">&#160;<xsl:value-of select="concat($theCourse/credit, ' (', $theCourse/term, ') ', $theCourse/meeting_text)" /></div>
            <div class="course-div">&#160;<xsl:value-of select="concat($theCourse/course_level, ' / ', $theCourse/course_type)" /></div>
            <div class="course-div indent">&#160;<xsl:value-of select="$theCourse/description" /></div>
            <div class="course-div indent">&#160;<xsl:value-of select="$theCourse/notes" /></div>
            <div id="buildingIdDiv"><br />Building: <span id="buildingName">&#160;</span></div>
        </div>
    </div>
    <div class="row" id="divMap">
        <br /><div id="map-canvas">&#160;</div>
    </div>
  </xsl:template>
</xsl:stylesheet>