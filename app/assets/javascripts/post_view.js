var map;

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: parseFloat($("#show-map").data().lat), lng: parseFloat($("#show-map").data().lng)},
        zoom: 15
    });
    marker = new google.maps.Marker({
        position: {lat: parseFloat($("#show-map").data().lat), lng: parseFloat($("#show-map").data().lng)},
        map: map
    })


}