var geocoder = new google.maps.Geocoder();
var form = "<div id='streetAddress' style='width:200px; height: 100px;'></div>";

var steetinfowindow = new google.maps.InfoWindow({
    content: form
});


function geocodePosition(pos) {
    geocoder.geocode({
        latLng: pos
    }, function(responses) {
        if (responses && responses.length > 0) {
						console.log(responses);
						var state = responses[0].address_components[1].long_name;
            updateMarkerAddress(responses[0].formatted_address, state);
        } else {
            updateMarkerAddress('Cannot determine address at this location.', '');
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
      html.innerHTML = info + "<hr>" + "<a href='#main' id='show_form'>Сообщить</a>";
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
        zoom : 15,
        minZoom: 9,
        center: latLng,
        zoomControl: true,
        panControl: true,
        streetViewControl: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    var map = new google.maps.Map(document.getElementById('report_map'), options);

    var marker = new google.maps.Marker({
        position: latLng,
        title: 'Point A',
        map: map,
        draggable: true
    });

    // Update current position info.
    updateMarkerPosition(latLng);
    geocodePosition(latLng);

    // Add dragging event listeners.
    google.maps.event.addListener(marker, 'dragstart', function() {
        //updateMarkerAddress('Dragging...');
        steetinfowindow.close();
    });

    google.maps.event.addListener(marker, 'drag', function() {
        updateMarkerStatus('Dragging...');
        updateMarkerPosition(marker.getPosition());
    });

    google.maps.event.addListener(marker, 'dragend', function() {
        updateMarkerStatus('Drag ended');
        geocodePosition(marker.getPosition());
        steetinfowindow.open(map, marker);
    });
}

function show_form() {
    alert('You are clicked');
}

function getKgMap(lat, lng, zoom, iszoom) {
    var options;
    var minKgZoom;
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
        point = event.latLng;

        for (var i = 0; i < polys.length; i++) {
            if (polys[i].Contains(point)) {
                var area = polys[i].Area() / 1000000;
                var sqmiles = area / 2.58998811;
                var T2 = new Date();

                var lid = null;
                var f = false;

                for (j in labels[i]) {
                    data += '<b>' + labels[i]['label']['name'] + '</b>';
                    data += '<hr><a href=\'#\' id="' + labels[i]['label']['id'] + '">Перейти в область</a>';

                    lid = labels[i]['label']['id'];
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
    if (lid == "io")
        getKgMap(42.472097, 78.384361, 9, true);
    if (lid == "oo")
        getKgMap(40.528284, 72.801075, 9, true);
    if (lid == "bo")
        getKgMap(40.053570, 70.816069, 9, true);
    if (lid == "no")
        getKgMap(41.425352, 75.998054, 9, true);
    if (lid == "to")
        getKgMap(42.517062, 72.233520, 9, true);
    if (lid == "jo")
        getKgMap(40.934719, 72.999859, 9, true);
    if (lid == "co")
        getKgMap(42.874958, 74.586868, 9, true);
    if (lid == "bi")
        getKgMap(42.874958, 74.586868, 11, true);
}

window.onload = initialize;
