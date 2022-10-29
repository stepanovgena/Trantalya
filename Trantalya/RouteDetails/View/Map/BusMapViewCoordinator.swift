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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        if let annotation = annotation as? BusAnnotation {
            return makeBusAnnotationView(annotation: annotation, mapView: mapView)
        }
        
        return nil
    }
}

private extension BusMapViewCoordinator {
    func makeBusAnnotationView(
        annotation: BusAnnotation,
        mapView: MKMapView
    ) -> MKAnnotationView {
        let reuseIdentifier = NSStringFromClass(BusAnnotation.self)
        let busAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation)
        busAnnotationView.canShowCallout = false
        busAnnotationView.image = UIImage(systemName: "bus.fill")?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        return busAnnotationView
    }
}


