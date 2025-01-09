const pointList = events.map(
  (point) => new L.LatLng(point.latitude, point.longitude)
);

var firstpolyline = new L.Polyline(pointList, {
  color: "blue",
  weight: 5,
  opacity: 0.5,
  smoothFactor: 5,
});

firstpolyline.addTo(mapInstance);
mapInstance.fitBounds([
  firstpolyline._bounds._northEast,
  firstpolyline._bounds._southWest,
]);
