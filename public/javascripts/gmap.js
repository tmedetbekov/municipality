var geocoder = new google.maps.Geocoder();
var form = "<div id='streetAddress' style='width:250px; height: 100px;'></div>";
var helpInfo = "<div style='height:50px;'><span>Перетащите маркер на проблемную зону</span></div>";

var streetInfoWindow = new google.maps.InfoWindow({
  content: form
});

var firstInfoWindow = new google.maps.InfoWindow({
  content : helpInfo
})


function geocodePosition(pos) {
  geocoder.geocode({
    latLng: pos
  }, function(responses) {
    if (responses && responses.length > 0) {
      var state = responses[0].address_components[1].long_name;
      updateMarkerAddress(responses[0].formatted_address, state);
    } else {
      updateMarkerAddress('Адресс не найден! укажите адресс вручную.', '');
    }
  });
}

function updateMarkerStatus(str) {
  //document.getElementById('markerStatus').innerHTML = str;
}

function updateMarkerPosition(latLng) {
  var str = [latLng.lat(),latLng.lng()].join(', ');
  $('#respond form input#report_coordinates').val(str);
}

function updateMarkerAddress(str, state) {
  var info = str.replace('Киргизия', 'Кыргызстан');
  html = document.getElementById('streetAddress');
  if (html) {
    html.innerHTML = info + "<br><hr>" + "<a href='#main' id='show_form'>Заполнить форму</a>";
  }
  if (state == 'Бишкек')
    $('#respond form input#report_state_id').val(8);
  if (state == 'Чуйская' || state == 'Чуйская область' || state == 'Chui' || state == 'Panfilov' || state == 'Киргизия')
    $('#respond form input#report_state_id').val(1);
  if (state == 'Ош' || state == 'Ошская область')
    $('#respond form input#report_state_id').val(2);
  if (state == 'Batken' || state == 'Баткенская область')
    $('#respond form input#report_state_id').val(3);
  if (state == 'Джалал-Абад' || state == 'Джалал-Абадская область')
    $('#respond form input#report_state_id').val(4);
  if (state == 'Talas' || state == 'Таласская область')
    $('#respond form input#report_state_id').val(5);
  if (state == 'Каракол' || state == 'Иссык-Кульская область')
    $('#respond form input#report_state_id').val(6);
  if (state == 'Нарын' || state == 'Нарынская область')
    $('#respond form input#report_state_id').val(7);

  $('#respond form input#report_address').val(info);

}

function getState(lat, lng, zoom) {
  var latLng = new google.maps.LatLng(lat, lng);

  options = {
    zoom : zoom,
    minZoom: 9,
    center: latLng,
    zoomControl: true,
    panControl: true,
    streetViewControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  var markerImage = "/images/add.png";
  var map = new google.maps.Map(document.getElementById('report_map'), options);

  var marker = new google.maps.Marker({
    position: latLng,
    title: 'Point A',
    map: map,
    icon : markerImage,
    draggable: true
  });


  firstInfoWindow.open(map, marker);
  // Update current position info.
  updateMarkerPosition(latLng);
  geocodePosition(latLng);

  // Add dragging event listeners.
  google.maps.event.addListener(marker, 'dragstart', function() {
    firstInfoWindow.close();
    $('.hidden_report_form').each(function() {
      $('#before-notice').hide(300);

      $('#respond :input').removeAttr('disabled');
    });

    streetInfoWindow.close();
  });

  google.maps.event.addListener(marker, 'drag', function() {
    updateMarkerStatus('Dragging...');
    updateMarkerPosition(marker.getPosition());
  });

  google.maps.event.addListener(marker, 'dragend', function() {
    updateMarkerStatus('Drag ended');
    geocodePosition(marker.getPosition());
    streetInfoWindow.open(map, marker);
  });
}

function show_form() {
  alert('You are clicked');
}

function getKgMap(lat, lng, zoom, iszoom) {
  var options;
  var latLng = new google.maps.LatLng(lat, lng);

  if (!iszoom) {
    options = {
      zoom : zoom,
      minZoom: 7,
      center: latLng,
      zoomControl: false,
      panControl: false,
      streetViewControl: false,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      disableDefaultUI: true,
      scrollwheel: false,
      mapTypeControl: true,
      mapTypeControlOptions  : {
        style : google.maps.MapTypeControlStyle.DROPDOWN_MENU
      }
    }

    var map = new google.maps.Map(document.getElementById('report_map'), options);
    return map;
  } else {
    getState(lat, lng, zoom);
  }
}

function initialize() {
  var polys = [];
  var labels = [];
  var point;
  var infowindow;

  var map = getKgMap(41.269550, 74.766098, 7, false);

  google.maps.event.addListener(map, "click", function(event) {
    var T1 = new Date();
    var data = '';
    var all_promlems = '';
    var solved = '';
    point = event.latLng;

    for (var i = 0; i < polys.length; i++) {
      if (polys[i].Contains(point)) {
        var area = polys[i].Area() / 1000000;
        var sqmiles = area / 2.58998811;
        var T2 = new Date();

        var lid = null;
        var f = false;

        for (j in labels[i]) {
          var sid = labels[i]['label']['id'];

          if (sid == 'co') {
            all_promlems = co_0 + co_1 + bi_0 + bi_1;
            solved = co_1 + bi_1;
          } else if(sid == 'oo') {
            all_promlems = oo_0 + oo_1;
            solved = oo_1;
          } else if (sid == 'bo') {
            all_promlems = bo_0 + bo_1;
            solved = bo_1;
          } else if (sid == 'jo') {
            all_promlems = jo_0 + jo_1;
            solved = jo_1;
          } else if (sid == 'to') {
            all_promlems = to_0 + to_1;
            solved = to_1;
          } else if (sid == 'io') {
            all_promlems = io_0 + io_1;
            solved = io_1;
          } else if (sid == 'no') {
            all_promlems = no_0 + no_1;
            solved = no_1;
          }

          a = all_promlems ? all_promlems : 0;
          s = solved ? solved : 0

          data += "<div style='width:270px; height:100px;'";
          data += '<b>' + labels[i]['label']['name'] + '</b><br/><hr/>';
          data += 'Общих проблем '  + a + ', решенных '+ s +'<br>';
          data += '<br/><a href=\'#\' id="' + sid + '">Перейти в область</a>';
          data += '</div>';

          lid = sid;
        }

        if (infowindow) infowindow.close();
        infowindow = new google.maps.InfoWindow({content: data, position : point });
        infowindow.open(map);

        $('a[id=' + lid + ']').live('click', function() {
          goto_state(lid);
        });

        if (true == f)
          $('a[id=' + lid + ']').click();
        f = false;

        i = 999;
      }
    }
  });

  jQuery.get('http://localhost:3000/states.xml', {}, function(data) {
    $(data).find('state').each(function() {
      var states = $(this);

      for (var a = 0; a < states.length; a++) {
        var lbl = $(states[a]).attr("name");
        var label_id = $(states[a]).attr('id');
        var colour = $(states[a]).attr("colour");
        var points = $(states[a]).find("point");
        var pts = [];
        for (var i = 0; i < points.length; i++) {
          pts[i] = new google.maps.LatLng(parseFloat($(points[i]).attr('lat')), parseFloat($(points[i]).attr('lng')));
        }

        poly = new google.maps.Polygon({
          paths: pts,
          strokeColor: "#000000",
          strokeOpacity: 1,
          strokeWeight: 1,
          fillColor: colour,
          fillOpacity: 0.5,
          clickable:false
        });

        var key = {
          'label': {
            'name': lbl,
            'id': label_id
          }
        };

        polys.push(poly);
        labels.push(key);
        poly.setMap(map);
      }
    });
  });

}

function goto_state(lid) {
  if (lid == 'co') {
    $('#respond form input#report_state_id').val(1);
    getKgMap(42.719777, 74.424819, 9, true);
  }
  else if (lid == "oo") {
    $('#respond form input#report_state_id').val(2);
    getKgMap(40.528284, 72.801075, 12, true);
  }
  else if (lid == "bo") {
    $('#respond form input#report_state_id').val(3);
    getKgMap(40.053570, 70.816069, 12, true);
  }
  else if (lid == "jo") {
    $('#respond form input#report_state_id').val(4);
    getKgMap(40.934719, 72.999859, 13, true);
  }
  else if (lid == "to") {
    $('#respond form input#report_state_id').val(5);
    getKgMap(42.517062, 72.233520, 12, true);
  }
  else if (lid == "io") {
    $('#respond form input#report_state_id').val(6);
    getKgMap(42.472097, 78.384361, 12, true);
  }
  else if (lid == "no") {
    $('#respond form input#report_state_id').val(7);
    getKgMap(41.425352, 75.998054, 14, true);
  }
  else if (lid == "bi") {
    $('#respond form input#report_state_id').val(8);
    getKgMap(42.874958, 74.586868, 12, true);
  }
}

window.onload = initialize;
