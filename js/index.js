/*
function centerFeaturedCourse(args) {
    // code modified from:
    // http://stackoverflow.com/questions/15090439/how-to-position-a-div-element-at-the-center-of-the-actual-screen-jquery
    $featuredCount = $('.featured_course_div').length;
    $featured_div = $('.featured_course_div').get($featuredCount - 3); // 1st course
    $container = $(window);
    $content = $($featured_div);
    $content.css("top", ($container.height() - $content.height()) / $container.height() - 125);
    $content.css("left", ($container.width() - $content.width()) / 4);
}
*/

$(document).ready(function() {
    $('#mnuIndex').addClass('active');

    $featuredCount = $('.featured_course_div').length;
    $featured_div_1 = $('.featured_course_div').get($featuredCount - 3); // 1st course
    $featured_div_2 = $('.featured_course_div').get($featuredCount - 2); // 2nd course
    $featured_div_3 = $('.featured_course_div').get($featuredCount - 1); // 3rd course

    // add classes to divs for showing/hiding on desktop browser resize as required via css
    $($featured_div_1 ).addClass('top_one');
    $($featured_div_2 ).addClass('hidden-xs');
    $($featured_div_2 ).addClass('hidden-sm');
    $($featured_div_2 ).addClass('hidden-md');
    $($featured_div_3 ).addClass('hidden-xs');
    $($featured_div_3 ).addClass('hidden-sm');
    $($featured_div_3 ).addClass('hidden-md');
    
    
    // mobile detect modified from:
    // http://stackoverflow.com/questions/3514784/what-is-the-best-way-to-detect-a-handheld-device-in-jquery
    /*
    if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
        // hide 2nd and 3rd featured courses
        $($featured_div_2).hide();
        $($featured_div_3).hide();

        // center first featured course
        centerFeaturedCourse();

        $(window).resize(function(){
           centerFeaturedCourse();
        });
    }
    */
 });