import { getBounds } from "./application";

const mapInstance = L.map("mapid");
L.tileLayer(
  "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
  {
    attribution:
      'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    id: "mapbox/streets-v11",
    accessToken:
      "pk.eyJ1IjoiYW1ibGVhcHAiLCJhIjoiY2s1MXFlc2tmMDBudTNtcDhwYTNlMXF6NCJ9.5sCbcBl56vskuJ2o_e27uQ",
  }
).addTo(mapInstance);

pointList = pointList.map(
  (point) => new L.LatLng(point.latitude, point.longitude)
);

if (env === "development") {
  const drift = () => (Math.random() / 250) * (Math.random() < 0.5 ? -1 : 1);
  for (let i = 0; i < 3; i++) {
    pointList = pointList.reduce((acc, el) => {
      acc.push({ lat: el.lat + drift(), lng: el.lng + drift() });
      return acc;
    }, pointList);
  }
}

if (bookmark.northeast_latitude) {
  mapInstance.fitBounds([
    [bookmark.northeast_latitude, bookmark.northeast_longitude],
    [bookmark.southwest_latitude, bookmark.southwest_longitude],
  ]);
} else {
  const bounds = getBounds(pointList);
  mapInstance.fitBounds([
    [bounds._northEast.lat, bounds._northEast.lng],
    [bounds._southWest.lat, bounds._southWest.lng],
  ]);
}

pointList.map((point) => {
  if (!point.lat) {
    throw new Error(JSON.stringify(point));
  }
  L.circle([point.lat, point.lng], {
    radius: 50,
    stroke: false,
    fillOpacity: 0.8,
  }).addTo(mapInstance);
});

mapInstance.addEventListener("moveend", (e) => {
  const bounds = mapInstance.getBounds();
  document.querySelector("[name='bookmark[northeast_latitude]']").value =
    bounds._northEast.lat;
  document.querySelector("[name='bookmark[northeast_longitude]']").value =
    bounds._northEast.lng;
  document.querySelector("[name='bookmark[southwest_latitude]']").value =
    bounds._southWest.lat;
  document.querySelector("[name='bookmark[southwest_longitude]']").value =
    bounds._southWest.lng;
});

document.querySelector(".js-toggle-overlay").addEventListener("change", (e) => {
  mapInstance.getPane("overlayPane").style.visibility = e.target.checked
    ? "visible"
    : "hidden";
});
