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
      <div class="col-lg-12">
        <h2>About This Catalog</h2>
        <div id="tabs">
            <ul class="tab_content hidden-xs hidden-sm hidden-md">
                <li><a href="#tabs-1">Overview</a></li>
                <li><a href="#tabs-2">Intro</a></li>
                <li><a href="#tabs-3">HTML5 Site</a></li>
                <li><a href="#tabs-4">Mobile Site</a></li>
                <li><a href="#tabs-5">PDF</a></li>
                <li><a href="#tabs-6">XML Stack</a></li>
                <li><a href="#tabs-7">Extraordinary Distinction</a></li>
                <li><a href="#tabs-8">Learnings</a></li>
            </ul>

            <div id="tabs-1">
                <p>Final Project</p>
                <p>CSCI E-18, Web Development with XML</p>
                <p>Fall, 2014</p>
                <p>Harvard Extension School</p>
                <p>Professor: David P. Heitmeyer</p>
                <p>TA: Francisco Isaza</p>
                <p>Students:</p>
                <ul>
                    <li>Claudio Bustamante</li>
                    <li>Robert Frenette</li>
                    <li>William Brikiatis</li>
                </ul>
                <p>
                  <span id="pdf-logo" class="pdf-logo hidden-xs hidden-small hidden-md">
                    <a href="project_report.pdf"><img src="pdf-logo.gif" class="pdf-logo hidden-xs hidden-small hidden-md" alt="PDF" /><br />Project Report.pdf</a>
                  </span>
                </p>
                <p>
                  <span id="pdf-logo-testing" class="pdf-logo hidden-xs hidden-small hidden-md">
                    <a href="test_results.pdf"><img src="pdf-logo.gif" class="pdf-logo hidden-xs hidden-small hidden-md" alt="PDF" /><br />Test Results.pdf</a>
                  </span>
                </p>
            </div>

            <!-- Intro -->
            <div id="tabs-2">
                <p>Project Introduction</p>
                <p>
                  This report presents a guide to the Navy team’s Final Project site. In addition, it acts as a review of the important functionality
                  and technologies for the CSCIE18 teaching staff. The key strategies, techniques and technologies used by the team to create
                  and implement the site are covered here.
                </p>
                <p>
                  To expedite review of the site, we structured the report to include the major sections that were presented in the online assignment document.
                  The major sections are:
                </p>
                <ul class="tab_content">
                  <li>Sites &amp; Content
                    <ul class="tab_content">
                      <li>XHTML (HTML5) Site</li>
                      <li>Searching and Browsing</li>
                    </ul>
                  </li>
                  <li>Mobile Site</li>
                  <li>PDF</li>
                  <li>XML Technology Implementations</li>
                  <li>Extraordinary Distinction</li>
                </ul>
                <p>Each major section reviews the important rubric items so the teaching staff will easily be able to determine if the site meets their requirements.</p>
                <p>
                  In addition, the Navy team implemented the site on Amazon Web Services
                  (<a href="http://ec2-54-84-45-120.compute-1.amazonaws.com/cocoon/final_project/">http://ec2-54-84-45-120.compute-1.amazonaws.com/cocoon/final_project/</a>),
                  making it easy for the teaching staff to review. The base configuration for AWS offers less than consistent performance and response times for the site
                  are sometimes significantly longer than when on localhost.
                </p>
            </div>

            <!-- HTML5 site -->
            <div id="tabs-3">
              <p>HTML5 Site</p>
              <p>
                The Navy project team developed the Harvard University, Faculty of Arts Course Catalog in HTML5.
                The site passes HTML5 validation except where the team created a namespace for a custom functions on the Search Results page.
                The custom function was used to pass params in the query string, which allowed the site to retrieve the proper results from the pagination filter.
              </p>
              <p>W3C's HTML5 specification does not allow custom namespaces. We discussed this with the teaching staff and it was agreed that this validation error would be allowed.</p>
              <p>
                To create the design for the site, the team used the Bootstrap CSS Framework, custom CSS, JavaScript DOM manipulation and XSLT imports
                of a common file to display the page headers and footers without repeating code (so the software is DRY). 
              </p>
              <br />
              <p>Searching and Browsing</p>
              <p>
                Course search is available to the user from a link in the top level navigation on the homepage and every other page on the site.
                The search courses page contains a form with the following input items:
              </p>
              <ul class="tab_content">
                <li>Departments (dropdown)</li>
                <li>Course Group (dropdown)</li>
                <li>Day (checkbox)</li>
                <li>Start Time (dropdown)</li>
                <li>Instructor (text)</li>
                <li>Term (checkbox)</li>
                <li>Free Form Text (text)</li>
              </ul>
              <p>
                The team restricted the Term to two choices: Spring and Fall. The data did not allow for other options.
                After reviewing the functionality and technologies used for searching and browsing, Navy team is convinced of the following points:
              </p>
              <ul class="tab_content">
                <li>There are sufficient search fields available to the user.</li>
                <li>Grouping (sorting) is available by Course Name and Professor.</li>
                <li>The user can easily select courses by department, term, course group, day, start time, professor, free form text or any combination of these seven selection criteria.</li>
                <li>Navigation is clear, concise and dynamically driven on the Search Results and Course Detail pages.</li>
                <li>Search results pages (HTML) are presented to the user with pagination, which helps to make presentation more appealing.</li>
              </ul>
            </div>

            <!-- Mobile site -->
            <div id="tabs-4">
              <p>
                In order to accommodate mobile phone users, the Navy team implemented a responsive design that adjusts for small screen sizes.
                The design has these features:
              </p>
              <ul class="tab_content">
                <li>Design elements are removed or changed to facilitate the use of fingers instead of mice.</li>
                <li>The navigation adjusts from a traditional desktop navigation to a mobile nav button with a fly-out menu for easier mobile use.</li>
                <li>The featured courses display on the homepage is dynamically reduced from three down to one course so that it takes up less real estate on smaller mobile screens.</li>
                <li>PDF icons are removed so that user does not try to display full sized documents on a smaller, mobile screen.</li>
              </ul>
              <p>
                The key point to consider is that ALL functionality is available using the mobile design, even the building location map
                (which will be discussed in the Extraordinary Distinction section).  However, it is important to keep in mind that mobile design achieves all functionality
                with no code duplication between the mobile site and the desktop site. The mobile design is achieved using XSLT and targeted use of the Twitter Bootstrap framework,
                custom CSS, and custom JavaScript and is HTML5 compliant.
              </p>
            </div>

            <!-- PDF -->
            <div id="tabs-5">
                <p>
                  Search results and detail course descriptions are available in PDF. Each individual course in the search results page is linked to the individual course description. 
                  This creates a PDF table of contents that the user can easily use to find more information about a course.
                </p>
                <p>The PDFs are generated via FO when the user clicks on a PDF icon. This makes it very easy to understand that PDF is available.</p>
                <p>The dynamically generated PDFs are fully functional PDF pages, and the user can save them and manipulate them as they would any other PDF.</p>
            </div>

            <!-- XML Stack -->
            <div id="tabs-6">
              <p>
                The Navy team's implementation completely separates presentation and data. All pages on the site are generated via XSLT.
                "Filter" XSLT files implement nearly all of the logic, except when the logic is for presentation purposes.
                Filter files are used to generate both HTML and FO presentation data. There is no duplication of logic to make this transform.
              </p>
              <p>
                We implemented all logic using XSLT and in a few cases JavaScript. There was no use of XQuery or database technology.
                The team combined data from both courses.xml and buildings.xml in order to generate the map on the course detail pages.
              </p>
              <p>
                Import of the common file was used to keep the presentation dry. If new departments were created, the new data would automatically be accessible to the user.
                New data fields (not included in the original design) would only require a few additional lines of code.
              </p>
              <p>Each display pipeline in the Sitemap passes a "title" param to the appropriate XSL. This is for two reasons:</p>
              <ul class="tab_content">
                <li>This allows setting the title of the page dynamically in the common XSL file</li>
                <li>The XSLT logic dynamically determines which CSS and JavaScript file(s) should be included for each page, and then it builds the includes. </li>
              </ul>
              <p>
                This was done for performance reasons, as it prevents the user from having to download all the JavaScript for the site if they don't visit every page.
                (Note that the code that performs the transformation for the JavaScript includes is contained in its own XSL, which is included by the common XSL layout.)
              </p>
              <br />
              <p>Search Form</p>
              <p>Here are some key points about the search form logic:</p>
              <ul class="tab_content">
                <li>It converts class start time to a 12-hour clock.</li>
                <li>The buildings for the course locations are called via AJAX request and returned in JSON</li>
                <li>The department selects are achieved via a transform when the page is requested.</li>
                <li>
                  The course group elements are obtained via an AJAX call to the course group filter.
                  This filter returns course group data in JSON format and it is stored in a JavaScript object, which is stored in a child element collection
                  of a departments JavaScript object.
                </li>
              </ul>
              <p>
                This ensures that only data for the course groups of the appropriate departments are passed, which reduces the processing requirement.
                Also, if a course group's data has already been requested, it is not requested again. Instead, it is retrieved via the JavaScript object.
              </p>
              <br />
              <p>New Requirements</p>
              <p>
                If incorporating additional data from other schools within Harvard was a requirement, it would be an easy task if the data was in the same XML format as courses.xml.
                Of course, the header in common.xsl would need to be adapted to the new schools and selection criteria for different schools would need to be incorporated,
                but the original architecture would be able to handle as much as 90-percent of the new requirements.
              </p>
              <p>
                If a new output architecture was required (e.g., XHTML, ODF), it would be very easy to generate it from the same filter files that are supplying data
                to the HTML5 and PDF versions. The Navy team built the architecture in a way that "future-proofed" the site.
              </p>
            </div>

            <!-- Extraordinary Distinction --> 
            <div id="tabs-7">
              <p>There are three areas where the Navy team went beyond the original requirements to include functionality not requested in the requirements document:</p>
              <ul class="tab_content">
                <li>Dynamically-generated featured courses on the home page.</li>
                <li>Course location mapping using Google Maps</li>
                <li>Course selection saving using local Storage</li>
              </ul>
              <br />
              <p>Dynamically-Generated Featured Courses</p>
              <p>
                Navy's homepage looks at enrollment.xml and dynamically selects the top classes in terms of the number of people registered for the class.
                The site then displays a summary of the courses on the home page. The desktop site displays the top three courses, and the mobile site displays the top course.
                Clicking the more info link will display the course detail page.
              </p>
              <p>
                XSLT was used to combine the necessary data from courses.xml and enrollment.xml. The result is a fun way to look at what is "trending"
                in terms of what are the popular classes. The home page could easily be adjusted to use other criteria for displaying classes on the home homepage if it was needed.
              </p>
              <br />
              <p>Course Location Mapping</p>
              <p>
                On both the Course Detail and My Courses pages, Google Maps functionality is incorporated to dynamically display the location of the building where the class is being held.
                This is implemented via a filter that processes data in the courses.xml and buildings.xml files. The filter returns the building's Lat and Long, in JSON format,
                to the AJAX call made via JavaScript. If a building is not available in the coruses.xml for the given course, the map is not displayed. Note that the map is implemented
                in a responsive manner so it is easily viewed in both desktop and mobile browsers.
              </p>
              <br />
              <p>Course Selection Saving</p>
              <p>
                A "Save" button is displayed in the upper-right of the courses detail page. Clicking this button will store information about the course in local storage
                (using custom JavaScript objects). JavaScript is also used to change the "Save" button's text to "Saved" when it is clicked. This indicates this course will be displayed
                on the My Courses page.
              </p>
              <p>
                When the user accesses the My Course page, JavaScript is used to retrieve the course information from local storage, hydrate JSON Objects,
                then display the courses in a table on the page. If a course has a building associated with it, a marker will be dynamically placed on the Google Map
                at the bottom of the page. In the event the User has saved more than one course with the same building, only one marker will be placed per building.
                If the User clicks a course name from the list of displayed courses, they will be taken to the Course Detail page for that course.
              </p>
            </div>

            <!-- Learnings --> 
            <div id="tabs-8">
                <p>Learnings:</p>
                <p>
                  Probably the most significant difficulty that the Navy team had was navigating Git as a team.
                  While we were experienced at using Git on our own, we did find that using it as a team could be difficult.
                  We had a number of times where there were conflicts and even had to work to restore the code to its previously optimal state.                  
                </p>
                <p>
                  On the other hand, our most significant advancement was creating the search results using XSLT.
                  There were a number of hurtles to overcome and significant help from the TAs was needed before we could get it working smoothly.
                  Properly configuring the site map for parameters involving resource files and filters was maybe the most rewarding accomplishment.
                  We hope that you‘ll agree that Navy has come up with an elegant solution.
                </p>
            </div>
        </div>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>