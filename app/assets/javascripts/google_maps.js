function createSidebarLi(json){
  return (
    "<div>" +
      "<h5><a>" + json.name + "</a></h5>" +
      '<p>mag: ' + json.mag + '</p>' +
      "long: " + json.lng + " lat: " + json.lat +
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
