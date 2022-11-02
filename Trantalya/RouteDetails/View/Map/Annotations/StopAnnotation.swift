//
//  StopAnnotation.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 29.10.2022.
//

import Foundation
import MapKit

/// Stop marker to be displayed on the map
final class StopAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    let isSelected: Bool
    
    init(
        coordinate: CLLocationCoordinate2D,
        isSelected: Bool
    ) {
        self.coordinate = coordinate
        self.isSelected = isSelected
    }
}
