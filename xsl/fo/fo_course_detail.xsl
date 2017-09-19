<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">

    <!-- formatting attributes -->
    <xsl:import href="fo_formatting.xsl" />

    <!-- param to store courses/course/@cat_num passed in querystring -->
    <xsl:param name="cat_num" />
  
    <!-- varaible to hold specific course -->
    <xsl:variable name="theCourse" select="courses/course[@cat_num eq $cat_num]" />
    <!-- var for holding dept_short_name -->
    <xsl:variable name="deptShortName" select="$theCourse/department/dept_short_name" />

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
            <!--  main content  -->
            <xsl:call-template name="main" />
        </fo:block>

        <fo:block id="theEnd"></fo:block>

        </fo:flow>
    </xsl:template>

    <!--
        templace for page title
    -->
    <xsl:template match="courses" mode="title">
        <fo:block xsl:use-attribute-sets="department-title">
            <xsl:value-of select="$theCourse/title" />
        </fo:block>
    </xsl:template>  

    <xsl:template name="main">
	<fo:block xsl:use-attribute-sets="course-info">
	<fo:block>
	    <xsl:text>Catalog Number: </xsl:text><xsl:value-of select="$theCourse/@cat_num" />
	</fo:block>
	<fo:block font-style="italic">
	    <xsl:value-of select="$theCourse/faculty_text" />
	</fo:block>
	<fo:block font-style="italic">
	    <xsl:value-of select="concat($theCourse/credit, ' (', $theCourse/term, ') ', $theCourse/meeting_text)" />
	</fo:block>
	<fo:block>
	    <xsl:value-of select="concat($theCourse/course_level, ' / ', $theCourse/course_type)" />
	</fo:block>

	<fo:block xsl:use-attribute-sets="course-info-indent">
	    <xsl:value-of select="$theCourse/description" />
	</fo:block>
	<fo:block xsl:use-attribute-sets="course-info-indent">
	    <xsl:value-of select="$theCourse/notes" />
	</fo:block>

    </fo:block>
    </xsl:template>

</xsl:stylesheet>