//
//  BusMapViewCoordinator.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 27.10.2022.
//

import Foundation
import MapKit

/// Constants used in file
fileprivate enum Constants {
    static var busCircleSize: CGFloat { 44 }
    static var busSize: CGFloat { 28 }
    static var stopIconSize: CGFloat { 16 }
    static var selectedStopIconSize: CGFloat { 20 }
}

/// Coordinator for bridging UIKit to SwiftUI view
final class BusMapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let bus = views.first(where: {
            $0.annotation is BusAnnotation
        }) {
            bus.superview?.bringSubviewToFront(bus)
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
        } else if let annotation = annotation as? StopAnnotation {
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
        guard
            let busImage = UIImage(systemName: "bus.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal),
            let circle = UIImage(systemName: "circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        else { return MKAnnotationView() }
        let circleSize = CGSize(
            width: Constants.busCircleSize,
            height: Constants.busCircleSize
        )
        let busSize = CGSize(
            width: Constants.busSize,
            height: Constants.busSize
        )
        busAnnotationView.image = UIGraphicsImageRenderer(size: circleSize).image { _ in
            circle.draw(in: CGRect(
                origin: .zero,
                size: circleSize
            ))
            let busOffset = (Constants.busCircleSize - Constants.busSize) / 2
            busImage.draw(in: CGRect(
                origin: CGPoint(
                    x: busOffset,
                    y: busOffset
                ),
                size: busSize
            ))
        }
        return busAnnotationView
    }
    
    func makeBusAnnotationView(
        annotation: StopAnnotation,
        mapView: MKMapView
    ) -> MKAnnotationView {
        let reuseIdentifier = NSStringFromClass(StopAnnotation.self)
        let stopAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation)
        stopAnnotationView.canShowCallout = false
        let imageName = annotation.isSelected
        ? "smallcircle.circle.fill"
        : "smallcircle.filled.circle.fill"
        let iconSize: CGFloat = annotation.isSelected
        ? Constants.selectedStopIconSize
        : Constants.stopIconSize
        let color: UIColor = annotation.isSelected
        ? .red
        : .blue
        guard let stopImage = UIImage(systemName: imageName)?
            .withTintColor(color, renderingMode: .alwaysOriginal)
        else { return MKAnnotationView() }
        let size = CGSize(width: iconSize, height: iconSize)
        stopAnnotationView.image = UIGraphicsImageRenderer(size: size).image { _ in stopImage.draw(in: CGRect(origin: .zero, size: size))
        }
        return stopAnnotationView
    }
}


