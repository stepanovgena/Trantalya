//
//  MapBus.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 26.10.2022.
//

import Foundation

/// Bus representation for mapping
struct MapBus: Decodable {
    let busId: String
    let lat: String
    let lng: String
    let plateNumber: String
    let stopDiff: String
    let ac: String
    let bike: String
    let timeDiff: Int
}
