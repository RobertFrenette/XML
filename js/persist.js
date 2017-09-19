/* varaibles */
var courses = [];
var userFactory = new UserFactory(courses);

/*
 * This function clears local storage for the provided key
 *
 * @key - key to be cleared in local storage
 */
function clearLocalStorage(key) {
    window.localStorage.removeItem(key);
}

/*
 * This function stored key/value pairs in local storage
 *
 * @key - key for local storage
 * @val - data (values) to be stored
 * @isJSON - if true, stringify data
 */
function persistData(key, val, isJSON) {
    localStorage.removeItem(key); // clear existing Local Storage entries

    if (isJSON) { // user_data
        if (val.length > 0) {
            window.localStorage.setItem(key, JSON.stringify(val));
        }
    } else { // reg_user
        window.localStorage.setItem(key, val);
    }
}

/*
 * This function retrieves data from local storage
 *
 * @key - key to retrieve data from local storage
 * @isJSON - if true, parse data
 *
 * @return data from local storage
 */
 function retrieveData(key, isJSON) {
    if (isJSON) { // reg_user
        return JSON.parse(window.localStorage.getItem(key));
    } else { // user_creds
        return window.localStorage.getItem(key);
    }
}

/*
 * This function retrieves data for provided key from local storage
 */
function retrieveUserData(key, userFactory) {
    // check for data in local storage
    var data = window.localStorage.getItem(key);

    if (data != undefined) {
        data = JSON.parse(data);
        // load data from local storage into Array (as objects)
        var userIndx = 0;
        data.forEach(function(d) {
            var list = d['userName'];
            // don't load null courses! (set to null when deleted by User)
            if (list != null) {
                // add users
                userFactory.addUser(d['userName']);
                // add courses
                var courses = d['courseFactory']['courses']; 
                courses.forEach(function(course) {
                    var courseTitle = course['courseTitle'];
                    if (courseTitle != null) { // load course
                        userFactory.users[userIndx].addCourse(course['courseTitle'], course['courseCatNum'], course['courseBuildingName']);
                    } // else skip course
                });

                userIndx++;
            }
        });
    } 
}

/*
 * This function traverses the courses Array, pushing elements with a valid courseTitle
 * into a new Array, which is then returned.
 */
function removeNullItems(courses) {
  var tempArray = [];

  // iterate through courses
  courses.forEach(function(course) {
    var courseTitle = course.getCourseTitle();
    // check for null
    if (courseTitle !== null) {
      // push to tempArray
      tempArray.push(course);
    } // else skip null course
  });

  return tempArray;
}

/*
 * This function checks to see if a course already exists for a given user.
 */
function courseExists(newCourseTitle, userName, users) {
    var exists = false;
    var BreakException = {};

    try {
        users.forEach(function(user) {

          // only check courses for specific user
          if (userName == user.getUserName()) {

            var courses = user.getCourses();
            courses.forEach(function(course) {
              if (newCourseTitle == course.getCourseTitle()) {
                exists = true;
                throw BreakException; // break out of loop
              } // else skip this existing course
            });
          } // else skip this user
        });
    } catch(ex) {
      // check to ensure we caught the BreakException
      if (ex !== BreakException) {
        // not a BreakExcption
        alert('An error has occured.');
      } // else ignore
    }

    return exists;
}

/*
 * This function adds a new course to a user.
 */
function addCourse(newCourseTitle, newCourseCatNum, newCourseBuildingName, userName, users) {
    if (courseExists(newCourseTitle, userName, users)) {
        alert("You're already registerd for " + newCourseTitle + '.');
    } else {
        // the following indx should always be >= 0, as the user
        // has to exist for this coded to be executed
        var indx = getUserIndex(userName, users);
        users[indx].addCourse(newCourseTitle, newCourseCatNum, newCourseBuildingName);
        //alert('You  have successfully registered for: ' + newCourseTitle + '.');
        $('#btnReg').attr('class', 'btn btn-default glyphicon glyphicon-ok pull-right');
        $('#btnReg').text(' Saved');
    }
}

/*
 * This function returns the index of a user in the users Array
 */
function getUserIndex(userName, users) {
    var pos = -1;

    var len = users.length;
    // use for... Loop -vs- forEach as we need the index of the user
    for (var indx = 0; indx < len; indx++) {
      if (userName == users[indx].getUserName()) {
        pos = indx;
        break;
      }
    }

    return pos;
}

/*
 * This function removes users with null names from the users Array
 */
function removeNullUsers(users) {
  var tempArray = [];

  // iterate through users
  users.forEach(function(user) {
    var userName = user.getUserName();
    // check for null
    if (userName !== null) {
      // push to tempArray
      tempArray.push(user);
    } // else skip null user
  });

  return tempArray;
}

/*
 * This function adds a new user to the userFactory
 */
function addUser(newUserName, userFactory) {
    var success = false;
    var userIndx = userFactory.users.length;

    // check to see if the user already exists
    if (userIndx > 0) {
        // since there will only be 1 user in this App,
        // we'll ignore adding additional users for now
        /*
        if (listExists(newUserName, userFactory.users)) {
          alert(newUserName + ' already exists.');
        } else {
          userFactory.addUser(newUserName);
          alert(newUserName + ' added.');
          success = true;
        }
        */
    } else { // no existing users, so just add the new name
      userFactory.addUser(newUserName);
      success = true;
    }

    return success;
}

// /////////////////////////
// COURSE Obj
// /////////////////////////
/*
 * This function defines a Course Object.
 */
function Course(courseTitle, courseCatNum, courseBuildingName) {
  /* variables */
  this.courseTitle = courseTitle;
  this.courseCatNum = courseCatNum;
  this.courseBuildingName = courseBuildingName;

  /* getters */
  this.getCourseTitle = function() {
    return this.courseTitle;
  };
  this.getCourseCatNum = function() {
    return this.courseCatNum;
  };
  this.getCourseBuildingName = function() {
    return this.courseBuildingName;
  };  

  /* setters */
  this.setCourseTitle = function(courseTitle) {
    this.courseTitle = courseTitle;
  };
  this.setCourseCatNum = function(courseCatNum) {
    this.courseCatNum = courseCatNum;
  };

  this.setCourseBuildingName = function(courseBuildingName) {
    this.courseBuildingName = courseBuildingName;
  };
}

/*
 * CourseFactory instantiates an Array for holding Course Objects.
 */
function CourseFactory() {
  this.courses = new Array();
}

// CourseFactory prototype(s):
CourseFactory.prototype.addCourse = function(courseTitle, courseCatNum, courseBuildingName) {
  this.courses.push(new Course(courseTitle, courseCatNum, courseBuildingName));
};

// /////////////////////////
// USER Obj
// /////////////////////////
/*
 * This function defines a User Object.
 */
function User(userName) {
  /* variables */
  this.courseFactory = new CourseFactory();
  this.userName = userName;

  /* getters */
  this.getUserName = function() {
      return this.userName;
  };
  this.getCourses = function() {
    var courses = [];
    this.courseFactory.courses.forEach(function(course) {
        courses.push(course);
    });
    return courses;
  };

  /* setters */
  this.setUserName = function(userName) {
    this.userName = userName;
  };
  this.addCourse = function(courseTitle, courseCatNum, courseBuildingName) {
    this.courseFactory.addCourse(courseTitle, courseCatNum, courseBuildingName);
  };
}

/*
 * UserFactory instantiates an Array for holding User Objects.
 */
function UserFactory(users) {
  this.users = new Array();
}

// UserFactory prototype(s):
UserFactory.prototype.addUser = function(userName) {
  this.users.push(new User(userName));
};