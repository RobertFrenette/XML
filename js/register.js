function hideDetails() {
    $('#regMsg').text('You have no saved courses.');
    $('#tblBdy').empty();
    $('#btnClear').hide();
    $('#map-canvas').hide();    
}

$(document).ready(function() {
    $('#mnuRegister').addClass('active');

    $('.tablesorter').tablesorter({ 
        headers: { 
            // disable sorting on cols
            0: {
                 sorter: false 
            }, 
            1: {
                 sorter: false 
            }
        } 
    }); 

    initializeMap(false);

    // check for local storage support
    if (Modernizr.localstorage) {
        // get persisted User data
        retrieveUserData('user_data', userFactory);
        if (userFactory.users.length > 0) {
                userFactory.users.forEach(function(user) {
                    $courses = user.getCourses();

                    $courses.forEach(function(course) {
                        $buildingName = course.getCourseBuildingName();

                        $tblBdy = $('#tblBdy');

                        $aCourseName  = document.createElement('a');
                        $aCourseName.setAttribute('href', 'course_detail.html?cat_num=' + $.trim(course.getCourseCatNum()) + '&building=' + $buildingName + '&no_nav=true');
                        $aCourseName.appendChild(document.createTextNode(course.getCourseTitle()));

                        $tr = document.createElement('tr');
                        $tdCourseName = document.createElement('td');
                        $tdCourseBldg = document.createElement('td');

                        $tdCourseName.appendChild($aCourseName);
                        $tdCourseBldg.appendChild(document.createTextNode($buildingName));

                        $tr.appendChild($tdCourseName);
                        $tr.appendChild($tdCourseBldg);
                        $tblBdy.append($tr);

                        if ($buildingName.trim() != '') {
                            getLatLng($buildingName.replace('%20', ' '));
                        }
                    });
                });

            $('#regMsg').text('Your saved courses:');
            $('#btnClear').show();

            $('#btnClear').click(function () {
                $doClear = true;
                $continue = confirm('You are about to clear all saved courses.\n\nPress OK to continue.\n\n');
                if ($continue) {
                    // delete courses
                    clearLocalStorage('user_data');
                    hideDetails();
                }
            });
        } else {
            hideDetails();
        }
    } else {
        hideDetails();
    }
});