/* varaibles */
var courseGroups = [];
var departmentFactory = new DepartmentFactory(courseGroups);

function showCourseGroups() {
    $selCourseGroups = $('#course_groups');

    $selCourseGroups.empty();

    $selCourseGroups
        .append($('<option></option>')
        .attr('value', 'All')
        .text('All Course Groups'));

    $indx = $("#departments option:selected").index() - 1;
    $groups = departmentFactory.departments[$indx].getCourseGroups();

    $groups.forEach(function(group) {
        $selCourseGroups
        .append($('<option></option>')
        .attr('value', group.getCourseGroupCode())
        .text(group.getCourseGroupName()));
    });
}

/**
 * make AJAX call to course_groups.html to get 
 * the cours groups for the selected department,
 * returned in JSON format.
 */
function getCourseGroups(code) {
    $url = "course_groups.html?department=" + code;

    $.ajax({
        type: 'GET',
        url: $url,
        success: function(json) {

            $len = json.course_groups.length;
            for (var i = 0 ; i < $len; i++) {
                $course_group_name = json.course_groups[i].course_group;
                $course_group_code = json.course_groups[i].code;
                $indx = $("#departments option:selected").index() - 1; // offest for first option

                departmentFactory.departments[$indx].addCourseGroup($course_group_name, $course_group_code);
            }

            showCourseGroups();
        },
        error: function(e) {
           //console.log(e);
        }
    });
}

$(document).ready(function() {
    $('#mnuSearch').addClass('active');

    $('#departments').each(function () {
        $(this).val($(this).find('option[selected]').val());
    });

    $('#departments').change(function () {
        $indx = $('#departments option:selected').index();
        if ($indx > 0) {
            // get Course Groups for selected Department
            $dptCode = $('#departments').val();

            $indx = $("#departments option:selected").index() - 1;
            $groups = departmentFactory.departments[$indx].getCourseGroups();
            if ($groups.length == 0) {
                // only get the course groups once per page load
                getCourseGroups($dptCode);
            } else {
                showCourseGroups();
            }
        } else {
            // clear Course  Gropus Select element
            $selCourseGroups = $('#course_groups');
            $selCourseGroups.empty();
            $selCourseGroups
                .append($('<option></option>')
                .attr('value', 'All')
                .text('Select a Depatment'));
        }
    });

    /*
    $('#all_days').change(function() {
        $all_days = $('#all_days');
        $all_days_checked = $all_days.prop('checked');
        $meeting_day_len = $('[name="meeting_day"]').length;
        if ($all_days_checked) {
            for (var i = 1; i < $meeting_day_len; i++) {
                document.getElementsByName('meeting_day')[i].checked = false;
                document.getElementsByName('meeting_day')[i].disabled = true;
            }
        } else {
            for (var i = 1; i < $meeting_day_len; i++) {
                document.getElementsByName('meeting_day')[i].disabled = false;
            }
        }
    });
    */

    $('#frmSearch').submit(function() {
        $temp = $('#instructor_name').val().charAt(0).toUpperCase() + $('#instructor_name').val().slice(1);
        if ($temp.length > 0) {
            $('#instructor_name').val($temp);
        }
    });
});

function initDepartments() {
    $dptLen = $('#departments').children('option').length;
    $('#departments option').each(function() {
        $departmentName = $(this).val();
        if ($departmentName != "") {
            departmentFactory.addDepartment($departmentName);
        }
    });
}

// /////////////////////////
// COURSE Obj
// /////////////////////////
/*
 * This function defines a CourseGroup Object.
 */
function CourseGroup(courseGroupName, courseGroupCode) {
  /* variables */
  this.courseGroupName = courseGroupName;
  this.courseGroupCode = courseGroupCode;

  /* getters */
  this.getCourseGroupName = function() {
    return this.courseGroupName;
  };
  this.getCourseGroupCode = function() {
    return this.courseGroupCode;
  };

  /* setters */
  this.setCourseGroupName = function(courseGroupName) {
    this.courseGroupName = courseGroupName;
  };
  this.setCourseGroupCode = function(courseGroupCode) {
    this.courseGroupCode = courseGroupCode;
  };
}

/*
 * CourseGroupFactory instantiates an Array for holding CourseGroup Objects.
 */
function CourseGroupFactory() {
  this.courseGroups = new Array();
}

// CourseGroupFactory prototype(s):
CourseGroupFactory.prototype.addCourseGroup = function(courseGroupName, courseGroupCode) {
  this.courseGroups.push(new CourseGroup(courseGroupName, courseGroupCode));
};

// /////////////////////////
// Department Obj
// /////////////////////////
/*
 * This function defines a Department Object.
 */
function Department(departmentName) {
  /* variables */
  this.courseGroupFactory = new CourseGroupFactory();
  this.departmentName = departmentName;

  /* getters */
  this.getDepartmentName = function() {
      return this.departmentName;
  };
  this.getCourseGroups = function() {
    var courseGroups = [];
    this.courseGroupFactory.courseGroups.forEach(function(courseGroup) {
        courseGroups.push(courseGroup);
    });
    return courseGroups;
  };

  /* setters */
  this.setDepartmentName = function(departmentName) {
    this.departmentName = departmentName;
  };
  this.addCourseGroup = function(courseGroupName, courseGroupCode) {
    this.courseGroupFactory.addCourseGroup(courseGroupName, courseGroupCode);
  };
}

/*
 * DepartmentFactory instantiates an Array for holding Department Objects.
 */
function DepartmentFactory(departments) {
  this.departments = new Array();
}

// DepartmentFactory prototype(s):
DepartmentFactory.prototype.addDepartment = function(departmentName) {
  this.departments.push(new Department(departmentName));
};

initDepartments();