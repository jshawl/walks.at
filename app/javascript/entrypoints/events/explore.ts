import { fitPlaces } from "../application";
import type { Place } from "../";

let pointList = [...events];

if (env === "development") {
  const drift = () => (Math.random() / 250) * (Math.random() < 0.5 ? -1 : 1);
  for (let i = 0; i < 3; i++) {
    pointList = pointList.reduce((acc, el) => {
      acc.push({
        latitude: el.latitude + drift(),
        longitude: el.longitude + drift(),
      } as Place);
      return acc;
    }, pointList);
  }
}

if (bookmark.northeast_latitude && mapInstance) {
  console.log("yes mapinstance");
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

mapInstance.addEventListener("moveend", () => {
  const bounds = mapInstance.getBounds();
  document.querySelector<HTMLInputElement>(
    "[name='bookmark[northeast_latitude]']"
  )!.value = String(bounds._northEast.lat);
  document.querySelector<HTMLInputElement>(
    "[name='bookmark[northeast_longitude]']"
  )!.value = String(bounds._northEast.lng);
  document.querySelector<HTMLInputElement>(
    "[name='bookmark[southwest_latitude]']"
  )!.value = String(bounds._southWest.lat);
  document.querySelector<HTMLInputElement>(
    "[name='bookmark[southwest_longitude]']"
  )!.value = String(bounds._southWest.lng);
});

document
  .querySelector(".js-toggle-overlay")!
  .addEventListener("change", (e) => {
    mapInstance.getPane("overlayPane").style.visibility = (
      e.target! as HTMLInputElement
    ).checked
      ? "visible"
      : "hidden";
  });
