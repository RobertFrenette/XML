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
  <xsl:template match="courses">
      <div class="row">
        <div class="col-lg-8">
            <p>Make your selections to show a list of matching courses.</p>
            <form id="frmSearch" class="form-horizontal" role="form" action="search_results_page1.html" method="GET">
                <fieldset>
                    <legend>Department &#38; Course Group</legend>
                    <div class="form-group">
                        <span class="col-sm-2">&#160;</span>
                        <div class="col-sm-6">
                            <select id="departments" name="departments" title="Select a department">
                              <option selected="selected" value="All">All Departments</option>

                              <!-- dynamically populate HTML Select Options with Department names from courses.xml -->
                              <xsl:for-each-group select="course/department" group-by="dept_short_name">
                              <!-- sort by dept_short_name -->
                              <xsl:sort select="current-grouping-key()" />
                                    <option value="{@code}"><xsl:value-of select="current-grouping-key()" /></option>
                              </xsl:for-each-group>
                            </select>
                        </div>
                    </div>
                </fieldset>

                <fieldset>
                    <div class="form-group">
                        <span class="col-sm-2">&#160;</span>
                        <div class="col-sm-6">
                            <select id="course_groups" name="course_groups" title="Select a course group">
                              <option selected="selected" value="All">Select a Department</option>
                            </select>
                        </div>
                    </div>
                </fieldset><br />

                <fieldset>
                    <legend>Day and Time</legend>
                        <div class="form-group">
                            <label class="control-label col-sm-1" >Select Day<br />(default: all days)</label>
                            <div class="col-sm-6">
                              <span class="checkbox">
                                    <!-- These values can stay hard-coded -->
                                    <!--<label class="chkbx"><input type="checkbox" value="All" name="meeting_day" id="all_days" checked="checked" /> Any day</label>-->
                                    <label class="chkbx"><input type="checkbox" value="1" name="meeting_day" /> Mon</label>
                                    <label class="chkbx"><input type="checkbox" value="2" name="meeting_day" /> Tues</label>
                                    <label class="chkbx"><input type="checkbox" value="3" name="meeting_day" /> Wed</label>
                                    <label class="chkbx"><input type="checkbox" value="4" name="meeting_day" /> Thurs</label>
                                    <label class="chkbx"><input type="checkbox" value="5" name="meeting_day" /> Fri</label>
                                    <label><input type="checkbox" value="6" name="meeting_day" /> Sat</label>
                                </span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-2" for="begin_time">Select Start Time</label>
                            <div class="col-sm-6">
                                <select id="begin_time" name="begin_time" size="1">
                                    <option selected="selected" value="All">Any time</option>

                                    <!-- dynamically populate HTML Select Options with Course times from courses.xml -->
                                    <xsl:for-each-group select="distinct-values(course/schedule/meeting/@begin_time)" group-by=".">
                                    <!-- sort by time -->
                                    <xsl:sort select="current-grouping-key()" order="ascending" data-type="number" />
                                          <xsl:variable name="milTime"><xsl:value-of select="floor(current-grouping-key())" /></xsl:variable>
                                          <option value="{current-grouping-key()}">
                                                <!-- convert 24hr clock time to 12hr clock time for display -->
                                                <xsl:choose>
                                                      <xsl:when test="$milTime &lt; 1000"> <!-- up to 9:59am -->
                                                            <xsl:variable name="stdTime"><xsl:value-of select="$milTime" /></xsl:variable>
                                                            <xsl:value-of select="concat(substring($stdTime, 1, 1), ':', substring($stdTime, 2))" /> am
                                                      </xsl:when>
                                                      <xsl:when test="$milTime &gt;= 1000 and $milTime &lt; 1200"> <!-- 10:00am - 11:59am -->
                                                            <xsl:variable name="stdTime"><xsl:value-of select="$milTime" /></xsl:variable>
                                                            <xsl:value-of select="concat(substring($stdTime, 1, 2), ':', substring($stdTime, 3))" /> am
                                                      </xsl:when>
                                                      <xsl:when test="$milTime &gt;= 1200 and $milTime &lt; 1300"> <!-- 12:00pm - 1:00pm -->
                                                            <xsl:variable name="stdTime"><xsl:value-of select="$milTime" /></xsl:variable>
                                                            <xsl:value-of select="concat(substring($stdTime, 1, 2), ':', substring($stdTime, 3))" /> pm
                                                      </xsl:when>
                                                      <xsl:when test="$milTime &gt;= 1300 and $milTime &lt; 2200"> <!-- 1:00pm - 9:59pm-->
                                                            <xsl:variable name="stdTime"><xsl:value-of select="floor(($milTime div 100) - 12)" />:<xsl:value-of select="number(($milTime mod 100))" /></xsl:variable>
                                                            <xsl:choose>
                                                                  <xsl:when test="substring($stdTime, string-length($stdTime) - 1) = ':0'"> <!-- ex - convert 1:0 pm  to 1:00 pm -->
                                                                        <xsl:value-of select="$stdTime" />0 pm
                                                                  </xsl:when>
                                                                  <xsl:otherwise>
                                                                        <xsl:value-of select="$stdTime" /> pm
                                                                  </xsl:otherwise>
                                                            </xsl:choose>
                                                      </xsl:when>
                                                      <xsl:when test="$milTime &gt;= 2200 and $milTime &lt; 2400"> <!-- 10:00pm - 12:00am -->
                                                            <xsl:variable name="stdTime"><xsl:value-of select="floor(($milTime div 100) - 12)" />:<xsl:value-of select="number(($milTime mod 100))" /></xsl:variable>
                                                            <xsl:choose>
                                                                  <xsl:when test="substring($stdTime, string-length($stdTime) - 1) = ':0'"> <!-- ex - convert 10:0 pm  to 10:00 pm -->
                                                                        <xsl:value-of select="$stdTime" />0 pm
                                                                  </xsl:when>
                                                                  <xsl:otherwise>
                                                                        <xsl:value-of select="$stdTime" /> pm
                                                                  </xsl:otherwise>
                                                            </xsl:choose>
                                                      </xsl:when>
                                                </xsl:choose>
                                          </option>
                                    </xsl:for-each-group>
                                </select>
                            </div>
                        </div>
                </fieldset><br />

                <fieldset>
                    <legend>Instructor</legend>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="instructor_name">Last Name:</label>
                        <div class="col-sm-6">
                          <input type="text" class="form-control" id="instructor_name" name="instructor_name" />
                        </div>
                    </div>
                </fieldset><br />

                <fieldset>
                    <legend>Term</legend>
                    <div class="form-group">
                        <label class="control-label col-sm-1" >Select Term<br />(default: all terms)</label>
                        <div class="col-sm-6">
                              <span class="checkbox">
                                    <!-- These values can stay hard-coded since there are only Spring and Fall 2014 courses in the XML file -->
                                    <label class="chkbx"><input type="checkbox" value="Y" name="spring_term" /> Spring</label>
                                    <label><input type="checkbox" value="Y" name="fall_term" /> Fall</label>
                              </span>
                        </div>
                    </div>
                </fieldset>

                <fieldset>
                    <legend>&#160;</legend>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="search_text">Search Text:</label>
                        <div class="col-sm-6">
                          <input type="text" class="form-control" id="search_text" name="search_text" />
                        </div>
                    </div>
                </fieldset><br />

              <div class="form-group">        
                <div class="col-sm-offset-2 col-sm-10">
                  <span class="pull-right">
                        <button type="reset" class="btn btn-default">Reset</button>
                        &#160;
                        <button type="submit" class="btn btn-primary">Search</button>
                  </span>
                </div>
              </div>
            </form>
        </div>
      </div>
  </xsl:template>
</xsl:stylesheet>