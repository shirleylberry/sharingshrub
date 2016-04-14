$(function() {
  
  var map;
  function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 40.706, lng: -74.0088},
      zoom: 8
    });
  }

  initMap();
  
});


