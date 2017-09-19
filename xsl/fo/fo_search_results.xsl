<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

    <!-- formatting attributes -->
    <xsl:import href="fo_formatting.xsl" />
    <!-- import common params for search results filter/page -->
    <xsl:import href="../search_results_params.xsl" />

    <!-- params passed from sitemap pipeline -->
    <xsl:param name="baselink" />

    <!-- var for holding dept_short_name -->
    <xsl:variable name="deptShortName" select="courses/course/department/dept_short_name" />
    <!-- variable for holding number of course groups per department code -->
    <xsl:variable name="courseGroupCount" select="count(distinct-values(//courses/course/course_group/$course_groups))" />

    <!--
        template which matches on doc root
    -->
    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <!-- page sequencce for header and body -->
                <fo:simple-page-master
                    master-name="simple"
                    page-height="11in" page-width="8.5in"
                    margin-top="1.0in" margin-bottom="1.0in" margin-left="1.25in" margin-right="1.25in">

                    <fo:region-body margin-top="0.25in" />
                    <fo:region-before extent="0.5in" />

                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="simple">
                <xsl:call-template name="header" />
                <xsl:call-template name="body" />
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <!--
        template for page header
        ex: The Classics, Page 1 of 2
    -->
    <xsl:template name="header">
        <fo:static-content flow-name="xsl-region-before">

            <fo:block font-size="8pt" text-align="end">
                <xsl:value-of select="$deptShortName" />
                <xsl:text>, Page </xsl:text>
                <fo:page-number />
                <xsl:text> of </xsl:text>
                <fo:page-number-citation ref-id="theEnd" />
            </fo:block>

        </fo:static-content>
    </xsl:template>

    <!--
        template for body of doc
    -->
    <xsl:template name="body">
        <fo:flow flow-name="xsl-region-body">

        <fo:block>
            <!-- page title -->
            <xsl:apply-templates select="/courses" mode="title" />
            <!-- toc -->
            <xsl:apply-templates select="/courses" mode="toc" />
            <!--  main content  -->
            <xsl:apply-templates select="/courses" mode="main" />
        </fo:block>

        <fo:block id="theEnd"></fo:block>

        </fo:flow>
    </xsl:template>

    <!--
        templace for page title
    -->
    <xsl:template match="courses" mode="title">
        <fo:block xsl:use-attribute-sets="department-title">
            <xsl:text>Department of </xsl:text>
            <xsl:value-of select="$deptShortName" />
        </fo:block>
    </xsl:template>

    <!--
        templace for TOC, match on courses
    -->
    <xsl:template match="courses" mode="toc">
        <fo:block>
            <xsl:for-each-group select="course/department" group-by="../course_group">
            <xsl:sort select="concat(../department, current-grouping-key())" />
                <xsl:value-of select="current-grouping-key()" />
                <xsl:call-template name="courseListing" />
            </xsl:for-each-group>
        </fo:block>
    </xsl:template>

    <!--
        This template displays the courses in a group for a department.
    -->
    <xsl:template name="courseListing">        
        <xsl:for-each select="current-group()">
          <xsl:sort select="concat(../course_number/num_int, ../course_number/num_char, ../title)" data-type="number" />
            <fo:block xsl:use-attribute-sets="table-of-contents" text-align-last="justify">

                <!-- display course group name, only if there is more than 1 course group for the department -->
                <xsl:if test="$courseGroupCount > 1">
                    <xsl:if test="position() = 1">
                        <fo:block xsl:use-attribute-sets="course-group-name">
                            <xsl:value-of select="current-grouping-key()" />
                        </fo:block>
                    </xsl:if>
                </xsl:if>

                <fo:basic-link>
                    <xsl:attribute name="internal-destination">
                        <xsl:value-of select="generate-id()" />
                    </xsl:attribute>

                    <xsl:sort select="concat(../course_number/num_int, ../course_number/num_char, ../title)" data-type="number" />
                    <xsl:value-of select="concat(../course_group, ' ', ../course_number/num_int, ../course_number/num_char)" />
                    <xsl:value-of select="concat(' ', ../title)" />
                </fo:basic-link>

                <fo:leader leader-pattern="dots" />
                <fo:page-number-citation>
                    <xsl:attribute name="ref-id">
                        <xsl:value-of select="generate-id()" />
                    </xsl:attribute>
                </fo:page-number-citation>
            </fo:block>

        </xsl:for-each>
    </xsl:template>

    <xsl:template match="courses" mode="main">
        <xsl:for-each-group select="course/department" group-by="../course_group">

            <xsl:for-each select="current-group()">

                    <fo:block xsl:use-attribute-sets="course-info">
                    <fo:block id="{generate-id()}" break-before="page" font-weight="bold">
                        <xsl:value-of select="concat(../course_group, ' ', ../course_number/num_int, ../course_number/num_char, '. ', ../title)" />
                    </fo:block>
                    <fo:block>
                        <xsl:text>Catalog Number: </xsl:text><xsl:value-of select="../@cat_num" />
                    </fo:block>
                    <fo:block font-style="italic">
                        <xsl:value-of select="../faculty_text" />
                    </fo:block>
                    <fo:block font-style="italic">
                        <xsl:value-of select="concat(../credit, ' (', ../term, ') ', ../meeting_text)" />
                    </fo:block>
                    <fo:block>
                        <xsl:value-of select="concat(../course_level, ' / ', ../course_type)" />
                    </fo:block>

                    <fo:block xsl:use-attribute-sets="course-info-indent">
                        <xsl:value-of select="../description" />
                    </fo:block>
                    <fo:block xsl:use-attribute-sets="course-info-indent">
                        <xsl:value-of select="../notes" />
                    </fo:block>

                </fo:block>

            </xsl:for-each>
        </xsl:for-each-group>
    </xsl:template>

</xsl:stylesheet>