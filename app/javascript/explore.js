var mapInstance = L.map("mapid");
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

document
  .querySelector(".js-get-current-location")
  .addEventListener("click", () => {
    navigator.geolocation.getCurrentPosition((position) => {
      mapInstance.setView([
        position.coords.latitude,
        position.coords.longitude,
        mapInstance.getZoom(),
      ]);
    });
  });

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

const bounds = pointList.reduce(
  (acc, el) => {
    if (el.lat > acc._northEast.lat) {
      acc._northEast.lat = el.lat;
    }
    if (el.lng > acc._northEast.lng) {
      acc._northEast.lng = el.lng;
    }
    if (el.lat < acc._southWest.lat) {
      acc._southWest.lat = el.lat;
    }
    if (el.lng < acc._southWest.lng) {
      acc._southWest.lng = el.lng;
    }

    return acc;
  },
  {
    _northEast: {
      lat: -Infinity,
      lng: -Infinity,
    },
    _southWest: {
      lat: Infinity,
      lng: Infinity,
    },
  }
);

mapInstance.fitBounds([
  [bounds._northEast.lat, bounds._northEast.lng],
  [bounds._southWest.lat, bounds._southWest.lng],
]);

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
  console.log(mapInstance.getBounds());
});
