$(document).ready(function() {
    $('.tablesorter').tablesorter({ 
        headers: { 
            // disable sorting on cols
            0: {
                 sorter: false 
            }, 
            1: {
                 sorter: false 
            },
            2: {
                 sorter: false 
            }, 
            3: {
                 sorter: false 
            }, 
            4: { 
                sorter: false 
            },
            5: { 
                sorter: false 
            }
        } 
    }); 

    $rowCount = $('.tablesorter tr').length;
    if ($rowCount <= 1) {
        $('#pdf-logo').hide();
        $('#lblPage').hide();
        $('#lblResults').text('There are no courses which meet your search criteria.');
    }
    /*
    if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) || $rowCount <= 1) {
        
    }
    */
});