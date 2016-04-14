$("pages").ready(function (){
    var config1 = liquidFillGaugeDefaultSettings();
      config1.circleColor = "#FF7777";
      config1.textColor = "#FF4444";
      config1.waveTextColor = "#FFAAAA";
      config1.waveColor = "#FFDDDD";
      config1.circleThickness = 0.2;
      config1.textVertPosition = 0.2;
      config1.waveAnimateTime = 1000;


    var percentage = $('div.funding_chart').attr('percent')
    var gauge2 = loadLiquidFillGauge("event_fundraising_fillgauge", parseInt(percentage), config1);    
});

