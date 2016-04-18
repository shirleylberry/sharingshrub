$(".charities.show").ready(function(){
  var map;
  var charity_address = $('div.address').text()
  var infowindow = new google.maps.InfoWindow({});
  function initMap(address) {
    $.ajax({
      method: "GET",
      url: "https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&key=AIzaSyA7qy8qU7ERyigYI6Ebz3WwFR_4cGuS4zU"
    }).then(function(data){
      var position = data.results[0].geometry.location
      map = new google.maps.Map(document.getElementById('map'), {
        center: position,
        zoom: 15
      });
      var marker = new google.maps.Marker({
                position: position,
                char_name: $('div h2').text(),
                map: map
      });
      marker.addListener('click', function() {
                var markerInfo = "<h5>" + this.char_name + "</h5>"
                infowindow.setContent(markerInfo);
                infowindow.open(map, this);
      });
    })
  }

  initMap(charity_address);
})



