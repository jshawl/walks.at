import { Marker } from "..";

navigator.geolocation.getCurrentPosition((position) => {
  mapInstance.setView(
    [position.coords.latitude, position.coords.longitude],
    12
  );
});

let marker: Marker;
mapInstance.on("click", (e: { latlng: { lat: number; lng: number } }) => {
  if (marker) mapInstance.removeLayer(marker);
  const { lat, lng } = e.latlng;
  marker = L.marker([lat, lng]);
  marker.addTo(mapInstance);
  document.querySelector<HTMLInputElement>("[name='place[latitude]']")!.value =
    String(lat);
  document.querySelector<HTMLInputElement>("[name='place[longitude]']")!.value =
    String(lng);
});
