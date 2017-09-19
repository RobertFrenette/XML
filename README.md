# CSCI E-18: Web Development Using XML

## Harvard Extension School, Spring 2014

This Repo contains the Final Project for Team Navy (Rob Frenette, Bill Brikiatis and Claudio Bustamante).

## Implementation
The Navy team’s implementation completely separates presentation and data. All pages on the site are generated via XSLT. “Filter” XSLT files implement nearly all of the logic, except when the logic is for presentation purposes. Filter files are used to generate both HTML and FO presentation data. There is no duplication of logic to make this transform.

We implemented all logic using XSLT and in a few cases JavaScript. There was no use of XQuery or database technology. The team combined data from both courses.xml and buildings.xml in order to generate the map on the course detail pages.

Import of the common file was used to keep the presentation dry. If new departments were created, the new data would automatically be accessible to the user. New data fields (not included in the original design) would only require a few additional lines of code.

Each display pipeline in the Sitemap passes a "title" param to the appropriate XSL. This is for two reasons:
* This allows setting the title of the page dynamically in the common XSL file
* The XSLT logic dynamically determines which CSS and JavaScript file(s) should be included for each page, and then it builds the includes.

This was done for performance reasons, as it prevents the user from having to download all the JavaScript for the site if they don't visit every page. (Note that the code that performs the transformation for the JavaScript includes is contained in its own XSL, which is included by the common XSL layout.)

## Sites and Content

### HTML5 Site
The Navy project team developed the Harvard University, Faculty of Arts Course Catalog in HTML5. The site passes HTML5 validation except where the team created a namespace for a custom functions on the Search Results page. The custom function was used to pass params in the query string, which allowed the site to retrieve the proper results from the pagination filter.

W3C’s HTML5 specification does not allow custom namespaces. We discussed this with the teaching staff and it was agreed that this validation error would be allowed.

To create the design for the site, the team used the Bootstrap CSS Framework, custom CSS, JavaScript DOM manipulation and XSLT imports of a common file to display the page headers and footers without repeating code (so the software is DRY).

### Searching and Browsing
Course search is available to the user from a link in the top level navigation on the homepage and every other page on the site. The search courses page contains a form with the following input items:

 * Departments (dropdown) 
 * Course Group (dropdown) 
 * Day (checkbox)
 * Start Time (dropdown) 
 * Instructor (text)
 * Term (checkbox) 
 * Free Form Text (text)

The team restricted the Term to two choices: Spring and Fall. The data did not allow for other options. After reviewing the functionality and technologies used for searching and browsing, Navy team is convinced of the following points:

 * There are sufficient search fields available to the user .
 * Grouping (sorting) is available by Course Name and Professor.
 * The user can easily select courses by department, term, course group, day, start time, professor, free form text or any combination of these seven selection criteria.
 * Navigation is clear, concise and dynamically driven on the Search Results and Course Detail pages.
 * Search results pages (HTML) are presented to the user with pagination, which helps to make presentation more appealing.


### Mobile Site
In order to accommodate mobile phone users, the Navy team implemented a responsive design that adjusts for small screen sizes. The design has these features:


 * Design elements are removed or changed to facilitate the use of fingers instead of mice.
 * The navigation adjusts from a traditional desktop navigation to a mobile nav button with a fly-out menu for easier mobile use.
 * The featured courses display on the homepage is dynamically reduced from three down to one course so that it takes up less real estate on smaller mobile screens.
 * PDF icons are removed so that user does not try to display full sized documents on a smaller,
mobile screen.

The key point to consider is that ALL functionality is available using the mobile design, even the building location map (which will be discussed in the Extraordinary Distinction section).

However, it is important to keep in mind that mobile design achieves all functionality with no code duplication between the mobile site and the desktop site. The mobile design is achieved using XSLT and targeted use of the Twitter Bootstrap framework, custom CSS, and custom JavaScript and is HTML5 compliant.

### PDF Generation
Search results and detail course descriptions are available in PDF. Each individual course in the search results page is linked to the individual course description. This creates a PDF table of contents that the user can easily use to find more information about a course.

The PDFs are generated via FO when the user clicks on a PDF icon. This makes it very easy to understand that PDF is available.

The dynamically generated PDFs are fully functional PDF pages, and the user can save them and manipulate them as they would any other PDF.


## Extraordinary Distinction
There are three areas where the Navy team went beyond the original requirements to include functionality not requested in the requirements document:

### Dynamically-Generated Featured Courses
Navy’s homepage looks at enrollment.xml and dynamically selects the top classes in terms of the number of people registered for the class. The site then displays a summary of the courses on the home page. The desktop site displays the top three courses, and the mobile site displays the top course. Clicking the more info link will display the course detail page.

XSLT was used to combine the necessary data from courses.xml and enrollment.xml. The result is a fun way to look at what is “trending” in terms of what are the popular classes. The home page could easily be adjusted to use other criteria for displaying classes on the home homepage if it was needed.

### Course Location Mapping
On both the Course Detail and My Courses pages, Google Maps functionality is incorporated to dynamically display the location of the building where the class is being held. This is implemented via a filter that processes data in the courses.xml and buildings.xml files. The filter returns the building's Lat and Long, in JSON format, to the AJAX call made via JavaScript. If a building is not available in the coruses.xml for the given course, the map is not displayed. Note that the map is implemented in a responsive manner so it is easily viewed in both desktop and mobile browsers.

### Course Selection Saving
A "Save" button is displayed in the upper-right of the courses detail page. Clicking this button will store information about the course in local storage (using custom JavaScript objects). JavaScript is also used to change the "Save" button's text to "Saved" when it is clicked. This indicates this course will be displayed on the My Courses page.

When the user accesses the My Course page, JavaScript is used to retrieve the course information from local storage, hydrate JSON Objects, then display the courses in a table on the page. If a course has a building associated with it, a marker will be dynamically placed on the Google Map at the bottom of the page. In the event the User has saved more than one course with the same building, only one marker will be placed per building. If the User clicks a course name from the list of displayed courses, they will be taken to the Course Detail page for that course.
