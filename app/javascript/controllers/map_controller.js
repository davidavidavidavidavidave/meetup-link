import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    centre: Object
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    const centre = this.centreValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12"
    })
    this.#addMarkersToMap()
    this.#addCentreToMap(centre)
    this.#fitMapToMarkers()
  }

  #addCentreToMap(centre) {
    const popup = new mapboxgl.Popup().setHTML(centre.centre_window_html)

    const customMarker = document.createElement("div")
    customMarker.innerHTML = centre.centre_marker_html

    new mapboxgl.Marker(customMarker)
      .setLngLat([ centre.lng, centre.lat ])
      .setPopup(popup)
      .addTo(this.map)
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  // Production To make it work on Heroku, push your MapBox API Key:
  // heroku config:set MAPBOX_API_KEY=pk.eyJ1IjoicGR1b****************yZvNpTR_kk1kKqQ

}
