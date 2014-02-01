Template.contacts.rendered = ->
  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "http://maps.google.com/maps/api/js?sensor=false&libraries=places&callback=initializeMap"
  document.body.appendChild(script)

@initializeMap = ->

  mapOptions = {
    zoom: 12
  }

  @map  = new google.maps.Map(document.getElementById('map'), mapOptions)
  google.maps.event.addListener map, 'tilesloaded', ->
    console.log("Tiles loaded")


#var map = new GMaps({
#  el:"#map",
#  lat:59.9386505,
#  lng:30.3730258,
#  zoom:13,
#  zoomControl:true,
#  zoomControlOpt:{
#    style:"MEDIUM",
#    position:"RIGHT_BOTTOM"
#  },
#  panControl:true,
#  streetViewControl:false,
#  mapTypeControl:false,
#  overviewMapControl:false,
#  scrollwheel:false
#});

  styles = [
    {
      stylers:[
        { hue:"#3299c0" },
        { saturation:50 }
      ]
    },
    {
      featureType:"road",
      elementType:"geometry",
      stylers:[
        { lightness:100 },
        { visibility:"simplified" }
      ]
    },
    {
      featureType:"road",
      elementType:"labels",
      stylers:[
        { visibility:"off"},
        { hue:"green" },
        { saturation:50 }
      ]
    }
  ];
#
#  map.addStyle({
#    styledMapName:"Styled Map",
#    styles:styles,
#    mapTypeId:"map_style"
#  });
#
#  map.setStyle("map_style");
#
#
#  map.drawOverlay({
#    lat:59.9386505,
#    lng:30.3730258,
#    content:'<div class="overlay"></div>',
#    verticalAlign:'top'
#  });
