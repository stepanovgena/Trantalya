//
//  BusMapViewCoordinator.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 27.10.2022.
//

import Foundation
import MapKit

/// Coordinator for bridging UIKit to SwiftUI view
final class BusMapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
      if let annotationView = views.first, let annotation = annotationView.annotation {
        if annotation is MKUserLocation {
          let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
          mapView.setRegion(region, animated: true)
        }
      }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let renderer = MKPolylineRenderer(overlay: overlay)
      renderer.strokeColor = .blue
      renderer.lineWidth = 3.0
      return renderer
    }
}
