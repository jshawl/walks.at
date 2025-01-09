import { fitPlaces } from "../application";

let pointList = [...events];

if (env === "development") {
  const drift = () => (Math.random() / 250) * (Math.random() < 0.5 ? -1 : 1);
  for (let i = 0; i < 3; i++) {
    pointList = pointList.reduce((acc, el) => {
      acc.push({
        latitude: el.latitude + drift(),
        longitude: el.longitude + drift(),
      });
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
  fitPlaces(pointList);
}

pointList.map((point) => {
  L.circle([point.latitude, point.longitude], {
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
