function createSidebarLi(json){
  return (
    "<div class='quake_item'>" +
      "<a>" + json.name + "</a>" +
      "<div class='stat'>magnitude: " + json.mag + '</div>' +
      "<div class='stat'>long: " + json.lng + '</div>' +
      "<div class='stat'>lat: " + json.lat + '</div>' +
      "<div class='stat'>When: " + json.time + '</div>' +
    "</div>"
  );
};

function bindLiToMarker($li, marker){
  $li.on('click', function(){
    handler.getMap().setZoom(8);
    marker.setMap(handler.getMap()); //because clusterer removes map property from marker
    marker.panTo();
    google.maps.event.trigger(marker.getServiceObject(), 'click');
  })
};

function createSidebar(json_array){
  _.each(json_array, function(json){
    var $li = $( createSidebarLi(json) );
    $li.appendTo('#sidebar_container');
    bindLiToMarker($li, json.marker);
  });
};
