var map = null;
var marker;
var buildingName = '';

/**
 * Build map and position marker.
 */
function buildMap(lat, lng, title) {
  var myLatlng = new google.maps.LatLng(lat, lng);
  var mapOptions = {
    zoom: 16,
    center: myLatlng
  }

  if (map == null) {
        map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  }  

  marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: title
  });
}

/**
 * make AJAX call to building.html to get 
 * the lat and lng, returned in JSON format.
 */
function getLatLng(name) {
        $url = "building.html?building=" + name;

        $.ajax({
            type: 'GET',
            url: $url,
            success: function(json) {
                if (json.building.length >= 1) {
                        $lat  = json.building[0].lat;
                        $lng  = json.building[0].lng;
        
                        // build the map
                        buildMap($lat, $lng, name);
        
                        // display building name on page
                        $('#buildingName').text(name);
                }
            },
            error: function(e) {
               //console.log(e.message);
            }
        });
}


function initializeMap(courseDetailPage) {
        // default to Harvard Square
        $lat = 42.373532;
        $lng = -71.11896;
        $name = 'Harvard Square';
        google.maps.event.addDomListener(window, 'load');
        
        if (courseDetailPage) {
                $params = location.search.substring(location.search.indexOf('building')).split('&')[0];
                $delim = $params.indexOf('=');
                $buildingName = $params.substring($delim + 1, $params.length);
        
                // if building name was passed in, load new building marker
                if ($buildingName.trim() != '') {
                        buildingName = $buildingName.trim();
                        getLatLng($buildingName.replace('%20', ' '));
                } else {
                        // don't display building name or map
                        $('#buildingIdDiv').hide();
                        $('#map-canvas').hide();
                }
        }
}