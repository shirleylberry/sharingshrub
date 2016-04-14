$(document).on('ready page:load', function() {
  
  $("#geocode-address").click(function (e) {
    e.preventDefault();
    e.stopPropagation();
    var address = $('#event_address').val().replace(/\s/g, '+');
        // url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&key=" + "AIzaSyAiqpXlxW1KYp2cO93kgef_MC79S33qImc" ;

    var geocoder;
    var map;

    function initialize() {
      geocoder = new google.maps.Geocoder();
      var latlng = new google.maps.LatLng(-34.397, 150.644);
      var mapOptions = {
        zoom: 17,
        center: latlng
      }
      map = new google.maps.Map(document.getElementById("mini-map"), mapOptions);
    }
    function codeAddress(address) {
      initialize()
      geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          map.setCenter(results[0].geometry.location);
          var marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location
          });
          // INSERT EVENT LAT AND LNG INTO HIDDEN FORM FIELDS
          $('#event_longitude').val( results[0].geometry.location.lng() )
          $('#event_latitude').val( results[0].geometry.location.lat() )
          $('#event_city').val( results[0].formatted_address.split(",")[1].slice(1) )

        } else {
          alert("Whoops, please enter a valid address: (i.e. 123 Main Street)");
        }
      });
    }
    $('#map-box').html('<h4>Double check your event address!</h4><div id="mini-map" style="width: 100%; height: 250px;"></div>')
    codeAddress(address);
  })

  // var config1 = liquidFillGaugeDefaultSettings();
  // config1.circleColor = "#FF7777";
  // config1.textColor = "#FF4444";
  // config1.waveTextColor = "#FFAAAA";
  // config1.waveColor = "#FFDDDD";
  // config1.circleThickness = 0.2;
  // config1.textVertPosition = 0.2;
  // config1.waveAnimateTime = 1000;


  // var percentage = $('div.funding_chart').attr('percent')
  // var gauge2 = loadLiquidFillGauge("event_fundraising_fillgauge", parseInt(percentage), config1);   
});
