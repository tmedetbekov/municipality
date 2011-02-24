getKgMap = function (lat, lng, zoom) {
  var center = new google.maps.LatLng(lat, lng);

  var map = new google.maps.Map(document.getElementById('cluster_map'), {
    zoom: zoom,
    center: center,
    minZoom: 7,
    streetViewControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  var markers = [];
  var image ='';
  for (var i = 0; i < arr.length; i++) {
    var myLatLng = arr[i]['report']['coordinates'].split(', ');
    var image_id = arr[i]['report']['assets'][0]['id'];
    var image_file_name = arr[i]['report']['assets'][0]['image_file_name'];
    var report_id = arr[i]['report']['id'];
    var report_subject = arr[i]['report']['subject'];
    var report_address = arr[i]['report']['address'];
    var solved = arr[i]['report']['solved'];

    if (solved == true) {
      image = "/images/solved.png";
    } else {
      image = "/images/unsolved.png";
    }

    contentString = "<b><a href='/reports/" + report_id + "'>" + report_subject + "</a></b><hr><img src='/system/images/" + image_id + "/marker/" + image_file_name + "'/><br><span>" + report_address + "</span>";

    var infowindow = new google.maps.InfoWindow({
      content : ''
    });

    var latLng = new google.maps.LatLng(parseFloat(myLatLng[0]), parseFloat(myLatLng[1]));
    var marker = new google.maps.Marker({
      position: latLng,
      icon : image,
      marker_info : contentString
    });

    google.maps.event.addListener(marker, 'click', function() {
      infowindow.setContent("<div id='marker_info'>" + this.marker_info + "</div>");
      infowindow.open(map, this);
    });

    markers.push(marker);
  }

  var markerCluster = new MarkerClusterer(map, markers);
}

function goto_state(lid) {
  if (lid == "io")
    getKgMap(42.472097, 78.384361, 15);
  if (lid == "oo")
    getKgMap(40.528284, 72.801075, 15);
  if (lid == "bo")
    getKgMap(40.053570, 70.816069, 15);
  if (lid == "no")
    getKgMap(41.425352, 75.998054, 15);
  if (lid == "to")
    getKgMap(42.517062, 72.233520, 15);
  if (lid == "jo")
    getKgMap(40.934719, 72.999859, 15);
  if (lid == "co")
    getKgMap(42.874958, 74.586868, 9);
  if (lid == "bi")
    getKgMap(42.874958, 74.586868, 11);
}


$(document).ready(function() {

  $("#login_link").click(function() {
    $('#commentform').modal();
  });

});
