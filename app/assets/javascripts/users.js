$('.users.show').ready(function(){
 var user_id = $('body').find('.pledged_events').attr('userId')

$.ajax({ 
  method: "GET",
  url: "/users/" + user_id + "/cause_chart"
}).success(function(data){
svg = d3.select("#cause_chart");
canvas = d3.select("#canvas");
art = d3.select("#art");
labels = d3.select("#labels");

// Create the pie layout function.
// This function will add convenience
// data to our existing data, like 
// the start angle and end angle
// for each data element.
jhw_pie = d3.layout.pie()
jhw_pie.value(function (d, i) {
    // Tells the layout function what
    // property of our data object to
    // use as the value.
    return d.amount;
});

// Set the size of our SVG element
svg.attr({
    height: 500,
    width: 700
});

// Store our chart dimensions
cDim = {
    height: $("#donut").outerHeight(),
    width: $("#donut").outerWidth(),
    labelRadius: 130
}

// This translate property moves the origin of the group's coordinate
// space to the center of the SVG element, saving us translating every
// coordinate individually. 
canvas.attr("transform", "translate(" + (cDim.width / 2) + "," + (cDim.width / 2) + ")");

pied_data = jhw_pie(data);

// The pied_arc function we make here will calculate the path
// information for each wedge based on the data set. This is 
// used in the "d" attribute.
pied_arc = d3.svg.arc()
    .innerRadius(160)
    .outerRadius(180);

// This is an ordinal scale that returns 10 predefined colors.
// It is part of d3 core.
pied_colors = d3.scale.category10();

// Let's start drawing the arcs.
enteringArcs = art.selectAll(".wedge").data(pied_data).enter();

enteringArcs.append("path")
    .attr("class", "wedge")
    .attr("d", pied_arc)
    .style("fill", function (d, i) {
    return pied_colors(i);
});

// Now we'll draw our label lines, etc.
enteringLabels = labels.selectAll(".label").data(pied_data).enter();
labelGroups = enteringLabels.append("g").attr("class", "label");
labelGroups.append("circle").attr({
    x: 0,
    y: 0,
    r: 1,
    fill: "#000",
    transform: function (d, i) {
        centroid = pied_arc.centroid(d);
        return "translate(" + pied_arc.centroid(d) + ")";
    },
        'class': "label-circle"
});

// "When am I ever going to use this?" I said in 
// 10th grade trig.
textLines = labelGroups.append("line").attr({
    x1: function (d, i) {
        return pied_arc.centroid(d)[0];
    },
    y1: function (d, i) {
        return pied_arc.centroid(d)[1];
    },
    x2: function (d, i) {
        centroid = pied_arc.centroid(d);
        midAngle = Math.atan2(centroid[0], centroid[0]);
        x = Math.cos(midAngle) * cDim.labelRadius;
        return x;
    },
    y2: function (d, i) {
        centroid = pied_arc.centroid(d);
        midAngle = Math.atan2(centroid[1], centroid[0]);
        y = Math.sin(midAngle) * cDim.labelRadius;
        return y;
    },
        'class': "label-line"
});

textLabels = labelGroups.append("text").attr({
    x: function (d, i) {
        centroid = pied_arc.centroid(d);
        midAngle = Math.atan2(centroid[1], centroid[0]);
        x = Math.cos(midAngle) * cDim.labelRadius;
        sign = (x > 0) ? 1 : -1
        labelX = x + (5 * sign)
        return labelX;
    },
    y: function (d, i) {
        centroid = pied_arc.centroid(d);
        midAngle = Math.atan2(centroid[1], centroid[0]);
        y = Math.sin(midAngle) * cDim.labelRadius;
        return y;
    },
        'text-anchor': function (d, i) {
        centroid = pied_arc.centroid(d);
        midAngle = Math.atan2(centroid[0], centroid[1]);
        x = Math.cos(midAngle) * cDim.labelRadius;
        return (x > 0) ? "start" : "end";
    },
        'class': 'label-text'
}).text(function (d) {
    return d.data.name
});

alpha = 1;
spacing = 12;

function relax() {
    again = false;
    textLabels.each(function (d, i) {
        a = this;
        da = d3.select(a);
        y1 = da.attr("y");
        textLabels.each(function (d, j) {
            b = this;
            // a & b are the same element and don't collide.
            if (a == b) return;
            db = d3.select(b);
            // a & b are on opposite sides of the chart and
            // don't collide
            if (da.attr("text-anchor") != db.attr("text-anchor")) return;
            // Now let's calculate the distance between
            // these elements. 
            y2 = db.attr("y");
            deltaY = y1 - y2;
            
            // Our spacing is greater than our specified spacing,
            // so they don't collide.
            if (Math.abs(deltaY) > spacing) return;
            
            // If the labels collide, we'll push each 
            // of the two labels up and down a little bit.
            again = true;
            sign = deltaY > 0 ? 1 : -1;
            adjust = sign * alpha;
            da.attr("y",+y1 + adjust);
            db.attr("y",+y2 - adjust);
        });
    });
    // Adjust our line leaders here
    // so that they follow the labels. 
    if(again) {
        labelElements = textLabels[0];
        textLines.attr("y2",function(d,i) {
            labelForLine = d3.select(labelElements[i]);
            return labelForLine.attr("y");
        });
        setTimeout(relax,1)
    }
}

relax();
   })
})