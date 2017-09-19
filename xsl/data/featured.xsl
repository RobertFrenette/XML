<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:param name="course_count" select="'4'" />

    <xsl:template match="enrollment">
        <featured_courses>
            <xsl:for-each select="course">
                <xsl:sort select="@total" order="descending" data-type="number" />
                <xsl:if test="position() &lt; number($course_count)">
                    <course>
                        <xsl:attribute name="cat_num">
                            <xsl:value-of select="@cat_num" />
                        </xsl:attribute>
                        <xsl:attribute name="total">
                            <xsl:value-of select="@total" />
                        </xsl:attribute>

                        <xsl:for-each select="document('../../data/courses.xml')//course[@cat_num=current()/@cat_num]">
                            <title>
                                <xsl:value-of select="title"/>
                            </title>
                            <department>
                                <xsl:value-of select="department/dept_short_name"/>
                            </department>
                            <course_num>
                                <xsl:value-of select="course_number/num_int"/>
                            </course_num>
                            <desc>
                                <xsl:value-of select="description"/>
                            </desc>
                            <building>
                                <xsl:value-of select="meeting_locations/location/@building" />
                            </building>
                        </xsl:for-each>
                    </course>
                </xsl:if>
            </xsl:for-each>
        </featured_courses>
    </xsl:template>
    
    <xsl:template match="text()" />
</xsl:stylesheet>