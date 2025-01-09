import { Place } from ".";

export const getBounds = (places: Place[]) =>
  places.reduce(
    (acc, el) => {
      if (el.latitude > acc._northEast.lat) {
        acc._northEast.lat = el.latitude;
      }
      if (el.longitude > acc._northEast.lng) {
        acc._northEast.lng = el.longitude;
      }
      if (el.latitude < acc._southWest.lat) {
        acc._southWest.lat = el.latitude;
      }
      if (el.longitude < acc._southWest.lng) {
        acc._southWest.lng = el.longitude;
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

export const fitPlaces = (places: Place[]) => {
  const bounds = getBounds(places);
  mapInstance?.fitBounds([
    [bounds._northEast.lat, bounds._northEast.lng],
    [bounds._southWest.lat, bounds._southWest.lng],
  ]);
};

const buttonGetCurrentLocation =
  document.querySelector(".js-get-current-location") ?? undefined;

buttonGetCurrentLocation?.addEventListener("click", () => {
  navigator.geolocation.getCurrentPosition((position) => {
    mapInstance.setView(
      [position.coords.latitude, position.coords.longitude],
      mapInstance.getZoom()
    );
  });
});
