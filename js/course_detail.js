$(document).ready(function() {
        initializeMap(true);

    // hide PDF logo if on mobile
    /*
    if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
        $('#pdf-logo').hide();
    }
    */

    // check for local storage support
    if (Modernizr.localstorage) {
        $courseStatus = $('#courseStatus').text();
        $courseTitle = $('#courseTitle').text();
        $courseCatNbr = $('#courseCatNbr').text();
        //$courseBuildingName = $('#buildingName').text();
        $courseBuildingName = buildingName.replace('%20', ' ');

        // get persisted User data
        retrieveUserData('user_data', userFactory);
        if (userFactory.users.length > 0) {
            // if course already exists, 
            if (courseExists($courseTitle, userFactory.users[0].getUserName(), userFactory.users)) {
                $('#btnReg').attr('class', 'btn btn-default glyphicon glyphicon-ok pull-right');
                $('#btnReg').text(' Saved');
            }
        } else { // create and persist the user
            // since there will only be 1 user in this App,
            // we'll default the user name for now
            addUser("user1", userFactory);
        }


        $('#btnReg').click(function () {
            $doReg = true;
            if ($courseStatus.indexOf('[') >= 0) {
                $continue = confirm('You are saving a course that is not currently offered.\n\nPress OK to continue.\n\n');
                if (!$continue) {
                    $doReg = false;
                }
            }
    
            if ($doReg) {
                // perist the course
                addCourse($courseTitle, $courseCatNbr, $courseBuildingName, userFactory.users[0].getUserName(), userFactory.users);
            }
        });


        $('#hrefResults').click(function (event) {
                event.preventDefault();
                history.back(1);
        });

        // Window's onbeforeunload event
        window.onbeforeunload = function () {
            persistData('user_data', userFactory.users, true); // useJSON
        };

    } else {
        // no local storage support, so hide Registration button
        $('#btnReg').hide();
    }
});