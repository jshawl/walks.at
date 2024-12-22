places.map(createPlaceMarker);

function createPlaceMarker(place) {
  var marker = L.marker([place.latitude, place.longitude]);
  marker.addTo(mapInstance).bindPopup(place.name);
  mapInstance.setView([place.latitude, place.longitude], 10);
}
