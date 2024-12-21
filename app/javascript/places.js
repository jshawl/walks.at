navigator.geolocation.getCurrentPosition((position) => {
  mapInstance.setView(
    [position.coords.latitude, position.coords.longitude],
    12
  );
});

let marker;
mapInstance.on("click", (e) => {
  if (marker) mapInstance.removeLayer(marker);
  const { lat, lng } = e.latlng;
  marker = L.marker([lat, lng]);
  marker.addTo(mapInstance);
  document.querySelector("[name='place[latitude]']").value = lat;
  document.querySelector("[name='place[longitude]']").value = lng;
});
