$(".events.new, .events.create").ready(function(){
  
  $("#geocode-address").click(function (e) {
    e.preventDefault();
    e.stopPropagation();
    var address = $('#event_address').val().replace(/\s/g, '+'),
        geocoder,
        map;

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
  });
});


//EVENT ANALYTIC CHARTS
$('.events.show').ready(function(){

     var lat = parseInt($('.address').attr('lat'));
     var long = parseInt($('.address').attr('long'));
     var myLatlng = new google.maps.LatLng( lat, long);
     var mapOptions = {
         zoom: 8,
         center: myLatlng
        }          
     var map = new google.maps.Map(document.getElementById("map"), mapOptions);
     var marker = new google.maps.Marker({
          position: myLatlng,
      });
    marker.setMap(map);



      //Draws Gauge Chart
      var config = liquidFillGaugeDefaultSettings();
      config.circleColor = "#FF7777";
      config.textColor = "#FF4444";
      config.waveTextColor = "#FFAAAA";
      config.waveColor = "#A9F5F2";
      config.circleThickness = 0.1;
      config.waveHeight = 0.2;
      config.waveAnimateTime = 1500;

      var percentage = $('div.funding_chart').attr('percent')
      var gauge = loadLiquidFillGauge("event_fundraising_fillgauge", parseInt(percentage), config);
      
      var event_id = $('body').find('#chart').attr('name')
      
      //Draws Growth Chart
      $.ajax({
        mehtod: "GET",
        url: "/events/" + event_id + "/growth_curve"
      }).success(function(data) {
        var svg = dimple.newSvg("#growth_chart", 700, 400);       
        var growth_chart = new dimple.chart(svg, data);
        growth_chart.setBounds(60, 30, 500, 300);
        var x = growth_chart.addCategoryAxis("x", "period")
        growth_chart.addMeasureAxis("y", "ratio");
        growth_chart.addColorAxis("ratio", ["green", "yellow", "red"]);
        // Add a thick line with markers
        var lines = growth_chart.addSeries(null, dimple.plot.line); 
        lines.lineWeight = 5;
        lines.lineMarkers = true;
        // Draw the chart
        growth_chart.draw();
      });
  
        //Draws Bar Chart
        $.ajax({ 
        method: "GET",
        url: "/events/" + event_id + "/bar_chart"
       }).success(function(data){
        var svg = dimple.newSvg("#bar_chart", 700, 400);
        var bar_chart = new dimple.chart(svg, data);
        bar_chart.setBounds(60, 30, 510, 305)
        var x = bar_chart.addCategoryAxis("x", "date");
        x.addOrderRule("Date");
        bar_chart.addMeasureAxis("y", "amount");
        bar_chart.addSeries(null, dimple.plot.bar);
        bar_chart.draw();
      });

})       


//SEARCH BY EVENT-DATES
$('.events.index').ready(function(){
     $("#events_search").submit(function(event){
       event.preventDefault();
       $('#result').empty();
     
      $.ajax({
      url: "/events/search",
      method: "get",
      data: ($("#events_search").serialize())
      }).success(function(data){
       for (var index in data) {    
         var event = data[index];
         var text = '<a id= '+ event.id + ' href = "/events/'+ event.id + '">' + event.title +'</p>';  
         $('#result').append(text);
       }
    })
     return false;
  });
});
  
