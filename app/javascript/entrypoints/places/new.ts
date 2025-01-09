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
  document.querySelector<HTMLInputElement>("[name='place[latitude]']")!.value =
    lat;
  document.querySelector<HTMLInputElement>("[name='place[longitude]']")!.value =
    lng;
});
