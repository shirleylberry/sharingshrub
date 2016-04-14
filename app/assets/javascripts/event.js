
  $(document).on('ready page:load', function (){
    
  //Draws Gauge Chart
  var config = liquidFillGaugeDefaultSettings();
    config.circleColor = "#FF7777";
    config.textColor = "#FF4444";
    config.waveTextColor = "#FFAAAA";
    config.waveColor = "#FFDDDD";
    config.circleThickness = 0.2;
    config.textVertPosition = 0.2;
    config.waveAnimateTime = 1000;

  var percentage = $('div.funding_chart').attr('percent')
  var gauge = loadLiquidFillGauge("event_fundraising_fillgauge", parseInt(percentage), config);
  
  var event_id = $('div.funding_chart').attr('id')
  $.ajax({
    mehtod: "GET",
    url: "/events/"+ event_id +"/growth_curve"
  }).success(function(data){

  var svg = dimple.newSvg("#growth_chart", 590, 400);       
 
      var growth_chart = new dimple.chart(svg, data);
      growth_chart.setBounds(60, 30, 500, 300);

      var x = growth_chart.addCategoryAxis("x", "period")
      growth_chart.addMeasureAxis("y", "ratio");

  

      // Min price will be green, middle price yellow and max red
      growth_chart.addColorAxis("Price", ["green", "yellow", "red"]);

      // Add a thick line with markers
      var lines = growth_chart.addSeries(null, dimple.plot.line); 
      lines.lineWeight = 5;
      lines.lineMarkers = true;
      
      // Draw the chart
      growth_chart.draw();
    
     })

  var percentage = $('div.funding_chart').attr('percent')
  var gauge2= loadLiquidFillGauge("event_fundraising_fillgauge", parseInt(percentage), config1);
 
})

