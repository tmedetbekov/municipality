getMap = function (lat, lng, zoom) {
  var center = new google.maps.LatLng(lat, lng);

  var map = new google.maps.Map(document.getElementById('cluster_map'), {
    zoom: zoom,
    center: center,
    minZoom: 7,
    streetViewControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  var markers = [];
  var markerIcon = '';
  var contentString = '';
  var img;
  for (var i = 0; i < arr.length; i++) {
    var myLatLng = arr[i]['report']['coordinates'].split(', ');
    var asset = arr[i]['report']['assets'][0];

    var report_id = arr[i]['report']['id'];
    var report_subject = arr[i]['report']['subject'];
    var report_address = arr[i]['report']['address'];
    var solved = arr[i]['report']['solved'];
    var image_id = asset ? arr[i]['report']['assets'][0]['id'] : 'noImage';
    var image_file_name = asset ? arr[i]['report']['assets'][0]['image_file_name'] : 'noImage';


    if (solved == true) {
      markerIcon = "/images/solved.png";
    } else {
      markerIcon = "/images/unsolved.png";
    }

    if (image_id != 'noImage') {
      img = "<img src='/system/images/" + image_id + "/marker/" + image_file_name + "'/>";
    } else {
      img = '';
    }

    contentString = "<b><a href='/reports/" + report_id + "'>" + report_subject + "</a></b><hr>"+img+"<br><span>" + report_address + "</span>";

    var infowindow = new google.maps.InfoWindow({
      content : ''
    });

    var latLng = new google.maps.LatLng(parseFloat(myLatLng[0]), parseFloat(myLatLng[1]));
    var marker = new google.maps.Marker({
      position: latLng,
      icon : markerIcon,
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
    getMap(42.472097, 78.384361, 12);
  if (lid == "oo")
    getMap(40.528284, 72.801075, 12);
  if (lid == "bo")
    getMap(40.053570, 70.816069, 12);
  if (lid == "no")
    getMap(41.425352, 75.998054, 14);
  if (lid == "to")
    getMap(42.517062, 72.233520, 12);
  if (lid == "jo")
    getMap(40.934719, 72.999859, 13);
  if (lid == "co")
    getMap(42.874958, 74.586868, 9);
  if (lid == "bi")
    getMap(42.874958, 74.586868, 12);
}

$(document).ready(function() {

  $("#login_link").click(function() {
    $('#overlay-content').modal();
    return false;
  });

  $('#email').focus(function(event) {
    $this = $(this);
    if($this.val() == 'E-mail') {
      $this.val('');
    }
  });

});
