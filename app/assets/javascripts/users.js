$('.users.show').ready(function(){
 var user_id = $('body').find('.pledged_events').attr('userId')

$.ajax({ 
  method: "GET",
  url: "/users/" + user_id + "/cause_chart"

}).success(function(data){
var width = 300,
    height = 300,
    radius = Math.min(width, height) / 2;

var color = d3.scale.category10()
var arc = d3.svg.arc()
    .outerRadius(radius - 10)
    .innerRadius(radius - 70);


var pie = d3.layout.pie()
  .startAngle(-90 * Math.PI/180)
  .endAngle(-90 * Math.PI/180 + 2*Math.PI)
  .value(function(d) { return d.amount; })
  .padAngle(.01)
  .sort(null);

    
var svg = d3.select("div.donut_chart").append("svg")
    .attr("width", width)
    .attr("height", height)
  .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");


var g = svg.selectAll(".arc")
      .data(pie(data))
    .enter().append("g")
      .attr("class", "arc");

  g.append("path")
      .attr("d", arc)
      .style("fill", function(d) { return color(d.data.name); });

  g.append("text")
      .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
      .attr("dy", ".35em")
      .text(function(d) { 
        return d.data.name; });

function type(d) {
  d.amount = +d.amount;
  return d;
}
})

})