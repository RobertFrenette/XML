<xsl:stylesheet 
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- import common params for search results filter/page -->
  <xsl:import href="../search_results_params.xsl" />

    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="courses">
        <courses>
            <xsl:apply-templates />
        </courses>
    </xsl:template>

    <xsl:template match="course[
        ($departments = '' or $departments = 'All' or department/@code = $departments)
        and
        ($course_groups = '' or $course_groups = 'All' or course_group/@code = $course_groups)
        and
        ($begin_time = '' or $begin_time = 'All' or schedule/meeting/@begin_time = $begin_time)
        and
        ($instructor_name_normalized = '' or $instructor_name_normalized = 'All' or faculty_list/faculty/name/last = $instructor_name_normalized)
        and
        ($meeting_day = '' or $meeting_day = 'All' or schedule/meeting/@day = $meeting_day_seq)
        and
        ($spring_term = '' or term/@spring_term = $spring_term)
        and
        ($fall_term = '' or term/@fall_term = $fall_term)
        and
        (contains(description, $search_text_normalized))
        ]">
            <xsl:for-each-group select="department" group-by="../course_group">
            <xsl:sort select="concat(../department, current-grouping-key())" />
                <xsl:call-template name="courseListing" />
            </xsl:for-each-group>
    </xsl:template>

  <xsl:template name="courseListing">
    <xsl:for-each select="current-group()">
      <xsl:sort select="concat(../course_number/num_int, ../course_number/num_char, ../title)" data-type="number" />

         <xsl:variable name="course" select=".." />

        <course>
            <xsl:attribute name="acad_year">
                <xsl:value-of select="$course/@acad_year" />
            </xsl:attribute>
            <xsl:attribute name="cat_num">
                <xsl:value-of select="$course/@cat_num" />
            </xsl:attribute>
            <xsl:attribute name="offered">
                <xsl:value-of select="$course/@offered" />
            </xsl:attribute>
    
            <term>
                <xsl:attribute name="term_pattern_code">
                    <xsl:value-of select="$course/term/@term_pattern_code" />
                </xsl:attribute>
                <xsl:attribute name="fall_term">
                    <xsl:value-of select="$course/term/@fall_term" />
                </xsl:attribute>
                <xsl:attribute name="spring_term">
                    <xsl:value-of select="$course/term/@spring_term" />
                </xsl:attribute>
                <xsl:value-of select="$course/term" />
            </term>
    
            <department>
                <xsl:attribute name="code">
                    <xsl:value-of select="$course/department/@code" />
                </xsl:attribute>
                <dept_short_name><xsl:value-of select="$course/department/dept_short_name" /></dept_short_name>
            </department>
    
            <course_group>
                <xsl:attribute name="code">
                    <xsl:value-of select="$course/course_group/@code" />
                </xsl:attribute>
                <xsl:value-of select="$course/course_group" />
            </course_group>
    
            <course_number>
               <num_int><xsl:value-of select="$course/course_number/num_int" /></num_int>
               <num_char><xsl:value-of select="$course/course_number/num_char" /></num_char>
            </course_number>
    
            <title><xsl:value-of select="$course/title" /></title>

            <course_type><xsl:value-of select="$course/course_level" /></course_type>
            <course_level><xsl:value-of select="$course/course_type" /></course_level>    

            <schedule>
                <xsl:for-each select="$course/schedule/meeting">
                    <meeting>
                        <xsl:attribute name="term">
                            <xsl:value-of select="@term" />
                        </xsl:attribute>
                        <xsl:attribute name="day">
                            <xsl:value-of select="@day" />
                        </xsl:attribute>
                        <xsl:attribute name="begin_time">
                            <xsl:value-of select="@begin_time" />
                        </xsl:attribute>
                    </meeting>
                </xsl:for-each>
            </schedule>
    
            <meeting_locations>
                <location>
                    <xsl:attribute name="building">
                        <xsl:value-of select="$course/meeting_locations/location/@building" />
                    </xsl:attribute>
                </location>
            </meeting_locations>
    
            <meeting_text><xsl:value-of select="$course/meeting_text" /></meeting_text>

            <xsl:choose>
                <xsl:when test="$course/faculty_text != ''">
                    <faculty_text><xsl:value-of select="$course/faculty_text" /></faculty_text>
                </xsl:when>
                <xsl:otherwise>
                    <faculty_text>
                        <xsl:value-of select="$course/faculty_list/faculty[1]/name/first" />&#160;
                        <xsl:value-of select="$course/faculty_list/faculty[1]/name/middle" />&#160;
                        <xsl:value-of select="$course/faculty_list/faculty[1]/name/last" />&#160;
                    </faculty_text>
                </xsl:otherwise>
            </xsl:choose>
    
            <description><xsl:value-of select="$course/description" /></description>

            <notes><xsl:value-of select="$course/notes" /></notes>
        </course>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="text()" />
</xsl:stylesheet>
