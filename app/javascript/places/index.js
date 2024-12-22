import { fitPlaces } from "../application.js";

places.map((place) => {
  var marker = L.marker([place.latitude, place.longitude]);
  marker.addTo(mapInstance).bindPopup(place.name);
});

fitPlaces(places);
