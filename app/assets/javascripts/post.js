var map;
var markers = [];

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: -33.406387, lng: -70.547424},
        zoom: 13
    });

    map.addListener('click', function (e) {
        placeMarkerAndPanTo(e.latLng, map);
    });

}


function placeMarkerAndPanTo(latLng, map) {
    deleteMarkers();
    checkCoordinates(latLng.lat(), latLng.lng());
    marker = new google.maps.Marker({
        position: latLng,
        map: map
    });
    markers.push(marker);
    map.panTo(latLng);
}

function setMapOnAll(map) {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(map);
    }
}

function clearMarkers() {
    setMapOnAll(null);
}

function deleteMarkers() {
    clearMarkers();
    $("#post_post_locations_lat").val("");
    $("#post_post_locations_lng").val("");
    $("#post_post_locations_location_id").val("");
    $("#set-location-button").removeClass('btn-success').addClass('btn-outline-success').html("Set location");
    markers = [];
}

function checkCoordinates(lat, lng) {
    $.ajax({
        url: 'https://api.fencer.io/v1.0/position',
        type: "GET",
        headers: {
            "Authorization": "31ef0786-ee49-5c75-be91-67525b5be6da",
            "Lat-Pos": lat,
            "Lng-Pos": lng
        },
        success: function (data) {
            if (data["data"]) {
                $("#map-alert").hide();
                $("#post_post_locations_lat").val(lat);
                $("#post_post_locations_lng").val(lng);
                $("#post_post_locations_location_id").val(data["data"][0]["id"])
                $("#set-location-button").removeClass('btn-outline-success').addClass('btn-success').html("Location established");
            } else {
                $("#map-alert").show();
            }
        }
    })

}






