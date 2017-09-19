<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="2.0"
                xmlns:courses="http://www.harvard.edu/courses">



  <!-- **************************************************************
        NOTE: Per an email sent to the E-18 Course Staff on 12/7,
              regarding the use of the course name-space declared above,
              which is needed for the custom function at the bottom of this page,
              this page is failing HTML5 validation.
              
              As noted in the email, the page passed validation prior to
              the use of the name-space/function.
              
              In the email we aseked:
              "Is it okay if our Search Results page fails validation,
                since we know what is causing it, and would otherwise pass
                if we weren’t using the namespace/function?
                Or do we have to rewrite our site to XHTML ...?
              
              In response to the email, Eric replied as follows:
              "Yes that's fine, just document it."
              
              Please consider this the documentation for this issue.
              
              Thanks!
       ************************************************************** -->



  <!-- import common page layout -->
  <xsl:import href="common.xsl" />
  <!-- import common params for search results filter/page -->
  <xsl:import href="search_results_params.xsl" />

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
    <div>
      <p>
        <span id="lblResults">The following are your search results: </span>
        <span id="pdf-logo" class="pull-right">
          <a href="search_results.pdf?{$querystring}"><img src="pdf-logo.gif" class="pdf-logo hidden-xs hidden-small hidden-md" alt="PDF" /></a>
        </span>
      </p>

      <div class="breadcrumb-nav main-breadcrumb-nav hidden-xs hidden-sm">
            <ul>
                <li><a href="{$baselink}search.html">Search Courses</a>
                    <ul>
                        <li>Search Results</li>
                    </ul>
                </li>
            </ul>
        </div>
      <br />
    </div>

    <div class="row">
      <div class="col-lg-12">
          <div class="table-responsive">
              <!-- table header -->
              <table class="tablesorter">
                  <thead>
                      <tr>
                          <th>Department</th>
                          <th>Course No.</th>
                          <th>Course Name</th>
                          <th>Term</th>
                          <th>Day / Time</th>
                          <th>Prof</th>
                      </tr>
                  </thead>

                  <tbody>
                  <!-- Build table body content -->
                  <xsl:for-each-group select="block/course/department" group-by="../course_group">
                  <!-- sort on department then course_group -->
                  <xsl:sort select="concat(../department, current-grouping-key())" />
                    <xsl:call-template name="courseListing" />
                  </xsl:for-each-group>
                  </tbody>

              <!-- table footer -->
              </table>
              <p id="lblPage">page:</p>
          </div>
      </div>
    </div>
    <!-- pagination links -->
    <div class="row">
      <div class="col-lg-12"><xsl:apply-templates select="//courses/block" /></div>
    </div>
  </xsl:template>

  <!--
      This template builds the XHTML to display the courses in a group for a department.
  -->
  <xsl:template name="courseListing">
    <xsl:for-each select="current-group()">
      <xsl:sort select="concat(../course_number/num_int, ../course_number/num_char, ../title)" data-type="number" />

      <!--
        The following var, and code in the associated <td> below,
        are used to change day values of 1, 2, 3, ... to M, Tu, W, ... for display.
        The code for this process was modified from a post on the Stack Overflow community forum.
      -->
      <xsl:variable name="daysOfWeek" select="('M','Tu','W','Th','F','Sa','Su')" />
      <xsl:variable name="building"><xsl:value-of select="../meeting_locations/location/@building"/></xsl:variable>
      <xsl:variable name="url"><xsl:value-of select="concat('course_detail.html?cat_num=', ../@cat_num, '&#38;building=', $building)" /></xsl:variable>
      <!--<xsl:variable name="url"><xsl:value-of select="encode-for-uri(concat('course_detail.html?cat_num=', ../@cat_num, '&#38;building=', $building))" /></xsl:variable>-->

        <tr>
          <td>
            <!-- only display first occurance of dept_short_name -->
            <xsl:if test="position() = 1">
              <xsl:value-of select="../department/dept_short_name" />
            </xsl:if>&#160;
          </td>
          <td>
              <a href="{$url}">
                <xsl:value-of select="concat(../course_group, ' ', ../course_number/num_int, ../course_number/num_char)" />
              </a>&#160;
          </td>
          <td>
              <xsl:if test="../@offered = 'N'">[ </xsl:if>
              <a href="{$url}">
                  <xsl:if test="../instructor_approval_required = 'Y'">&#42;</xsl:if>
                  <xsl:value-of select="../title" />
              </a>
              <xsl:if test="../@offered = 'N'"> ]</xsl:if>&#160;
          </td>
          <td><xsl:value-of select="../term" />&#160;</td>
          <!-- covert days 1, 2, 3... to M, Tu, W, ... -->
          <td>
            <xsl:for-each select="../schedule/meeting">
              <xsl:value-of select="for $n in tokenize(@day,' ') return $daysOfWeek[position()=number($n)]" separator=" "/>
              /
              <xsl:value-of select="@begin_time" /><br />
            </xsl:for-each>&#160;
          </td>
          <td><xsl:value-of select="../faculty_text" />&#160;</td>
        </tr>

    </xsl:for-each>
  </xsl:template>
  
  <!-- template for pagination -->
  <xsl:template match="block">
    <xsl:variable name="currentpage">
      <xsl:value-of select="//block[child::*]/@id" />
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="count(child::*) > 0">
        <xsl:value-of select="@id" />
      </xsl:when>
      <xsl:otherwise>
        <!--<a href="search_results_page{@id}.html?{$querystring}">-->
        <a href="search_results_page{@id}.html?{courses:qs()}">
          <xsl:value-of select="@id" />
        </a>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="position() != last()">
      <xsl:text> | </xsl:text>
    </xsl:if>
  </xsl:template>

  <!--
    function to generate query string
    uses params declared/populated at top of page
  -->
  <xsl:function name="courses:qs">
    <xsl:text>departments=</xsl:text>
    <xsl:value-of select="$departments" />
    <xsl:text>&amp;</xsl:text>
    <xsl:text>course_groups=</xsl:text>
    <xsl:value-of select="$course_groups" />

<!--
    <xsl:text>&amp;</xsl:text>
    <xsl:text>meeting_day=</xsl:text>
    <xsl:value-of select="$meeting_day" />
    <xsl:text>&amp;</xsl:text>
-->

    <xsl:for-each
     select="for $d in $meeting_day_seq return $d">
          <xsl:text>&amp;</xsl:text>
          <xsl:text>meeting_day=</xsl:text>
          <xsl:value-of select="." />
    </xsl:for-each>
    <xsl:text>&amp;</xsl:text>

    <xsl:text>begin_time=</xsl:text>
    <xsl:value-of select="$begin_time" />
    <xsl:text>&amp;</xsl:text>
    <xsl:text>instructor_name=</xsl:text>
    <xsl:value-of select="$instructor_name" />
    <xsl:text>&amp;</xsl:text>
    <xsl:text>spring_term=</xsl:text>
    <xsl:value-of select="$spring_term" />
    <xsl:text>&amp;</xsl:text>
    <xsl:text>fall_term=</xsl:text>
    <xsl:value-of select="$fall_term" />
    <xsl:text>&amp;</xsl:text>
    <xsl:text>search_text=</xsl:text>
    <xsl:value-of select="$search_text" />
  </xsl:function>

</xsl:stylesheet>