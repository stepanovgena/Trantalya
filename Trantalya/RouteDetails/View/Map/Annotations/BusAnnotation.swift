//
//  BusAnnotation.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 29.10.2022.
//

import Foundation
import MapKit

/// Bus marker to be displayed on the map
final class BusAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 36.77, longitude: 30.11)
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
