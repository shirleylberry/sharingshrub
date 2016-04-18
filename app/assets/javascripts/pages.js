$(document).on('ready page:load', function() {

    var map;
    var infowindow = new google.maps.InfoWindow({});

    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: 40.706, lng: -74.0088},
            zoom: 10
        });
    }

    initMap();

    $.get('/map_events')
     .success(function (events) {
        for ( var i in events ) {
            var marker = new google.maps.Marker({
                position: {
                    lat: events[i].latitude,
                    lng: events[i].longitude
                },
                id: events[i].id,
                map: map,
                title: events[i].title,
                start: events[i].event_start,
                end: events[i].event_end
            });
            marker.addListener('click', function() {
                var markerInfo = "<h4>" + this.title + "</h4>" +
                                 "<h5><a href='events/" + this.id + 
                                 "'>Check it out!</a></h5>";
                infowindow.setContent(markerInfo);
                infowindow.open(map, this);
            });
            marker.setMap(map);
        }       
    })
});


