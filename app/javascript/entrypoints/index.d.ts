type MapInstance = {
  addEventListener: (event: string, callback: () => void) => void;
  fitBounds: (args: unknown) => void;
  getBounds: () => {
    _northEast: { lat: number; lng: number };
    _southWest: { lat: number; lng: number };
  };
  getPane: (selector: string) => HTMLElement;
  getZoom: () => number;
  on: (event: string, callback: Function) => void;
  removeLayer: (marker: Marker) => void;
  setView: (coords: [number, number], zoom: number) => {};
};

export type Marker = { addTo: Function };
type L = {
  circle: (
    coordinate: [number, number],
    options: Record<string, unknown>
  ) => { addTo: Function };
  LatLng: new (latitude: number, longitude: number) => LeafletLatLng;
  marker: (coordinates: [number, number]) => Marker;
  Polyline: new (
    coordinates: LeafletLatLng[],
    options: Record<string, unknown>
  ) => {
    addTo: Function;
    _bounds: { _northEast: unknown; _southWest: unknown };
  };
};

declare global {
  var mapInstance: MapInstance;

  var L: L;

  var bookmark: {
    northeast_latitude: number;
    northeast_longitude: number;
    southwest_latitude: number;
    southwest_longitude: number;
  };
  var env: "development" | "production";
  var events: Place[];
  var place: Place;
  var places: Place[];
}

type LeafletLatLng = {};
export type Place = {
  latitude: number;
  longitude: number;
  name: string;
};
