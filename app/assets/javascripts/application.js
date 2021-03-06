// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require rails-ujs
//= require activestorage
//= require leaflet
//= require jquery3
//= require jquery_ujs
//= require popper
//= require turbolinks

//= require bootstrap-sprockets
//= require alertify
//= require alertify/confirm-ujs
//= require_tree .

alertify.set('notifier','position', 'top-right');

// Get the browsers coordinates to initialize the Map to its location
function getNavCoordinates(map, marker, lat, lng){
  if($(lat).val() == 0 && $(lng).val() == 0){
    if(navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function (position) {
        var nav_lat = position.coords.latitude,
            nav_lng = position.coords.longitude;
        $(lat).val(nav_lat);
        $(lng).val(nav_lng);
        map.setView([nav_lat, nav_lng], 15);
        marker.setLatLng(map.getCenter());
      });
    }else{
      $(lat).val(0);
      $(lng).val(0);
    }
  }
  //event.preventDefault();
}

// Initialize Map
function iniMap(map, marker, lat, lng, lgnd){

  L.tileLayer('http://a.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: 'Map data: &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors | &copy; Entrega App!',
    maxZoom: 19
  }).addTo(map);

  map.options.scrollWheelZoom = 'center';
  map.options.doubleClickZoom = 'center';
  map.options.touchZoom = 'center';

  var legend = L.control({position: 'bottomleft'});

  legend.onAdd = function (map) {

    var div = L.DomUtil.create('div', 'info legend leaflet-control-attribution');
    div.innerHTML = "<div id='" + lgnd.replace('#','') +"'>-</div>";

    return div;
  };

  legend.addTo(map);
  map.setView([$(lat).val(), $(lng).val()],15);
  getCenter(map, marker, lat, lng, lgnd)
}



function getCenter(map, marker, lat, lng, lgnd){
	var cnt = map.getCenter();
  marker.setLatLng(cnt);
  $(lat).val(cnt.lat);
	$(lng).val(cnt.lng);
	$(lgnd)[0].innerHTML = convertDMS(cnt.lat,cnt.lng);
}


function convertDMS( lat, lng ) {
 
  var convertLat = Math.abs(lat);
  var LatDeg = Math.floor(convertLat);
  var LatSeg = (convertLat - LatDeg) * 3600
  var LatMin = Math.floor(LatSeg / 60);
  LatSeg = Math.round(100*(LatSeg - (LatMin * 60)))/100;
  var LatCardinal = ((lat > 0) ? "N" : "S");
   
  var convertLng = Math.abs(lng);
  var LngDeg = Math.floor(convertLng);
  var LngSeg = (convertLng - LngDeg) * 3600
  var LngMin = Math.floor(LngSeg / 60);
  LngSeg = Math.round(100*(LngSeg - (LngMin * 60)))/100;
  var LngCardinal = ((lng > 0) ? "E" : "W");
   
  return LatDeg + 'º' + LatMin + '′' + LatSeg + '″' + LatCardinal   + " " + LngDeg + 'º' + LngMin + '′' + LngSeg + '″' + LngCardinal;
}

// Funcion to show coordinates using Open Street Map
function getCoordinatesFromAddressOSM(button){
  var address = encodeURIComponent($(button).closest('td').find('input#address').val());
  $.when($.ajax('https://nominatim.openstreetmap.org/search.php?q=' + address + '&format=json')).done(function(data){
    if (data.length > 0){
      map.setView([data[0].lat, data[0].lon],map.getZoom());
    } else{
      alert("No address found")
    }
  });
}

// Get distance between the two order points as the crow flies (stright line)
//function getDistanceBetweenOrderPointsInKm() {
//  var latitude0 = $('input[id="latitude0"]').val()
//  var latitude1 = $('input[id="latitude1"]').val()
//  var longitude0 = $('input[id="longitude0"]').val()
//  var longitude1 = $('input[id="longitude1"]').val()
//  var R = 6371; // Radius of the earth in km
//  if ((latitude1 == latitude0) && (longitude0 == longitude1)) {
//    return 0
//  }
//  else {
//
//  function deg2rad(deg) {
//    return deg * (Math.PI/180)
//  }
//
//  var diffLat = deg2rad(latitude1 - latitude0)
//  var diffLon = deg2rad(longitude1 - longitude0)
//  var a = 
//    Math.sin(diffLat/2) * Math.sin(diffLat/2) +
//    Math.cos(deg2rad(latitude0)) * Math.cos(deg2rad(latitude1)) * 
//    Math.sin(diffLon/2) * Math.sin(diffLon/2)
//  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
//  var d = R * c; // Distance in km
//  return d
//  }
//}   //console.log(getDistanceBetweenOrderPointsInKm()) // For visualization only on console

