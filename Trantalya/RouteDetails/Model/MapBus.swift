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
    let stopDiff: String?
    let ac: String
    let bike: String
//    Backend really bad with timeDiff,
//    same structure in two requests except in one it's String, in the other it's an Int
//    let timeDiff: Int
//    let timeDiff: Int
}
