//
//  MapStopResponse.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 02.11.2022.
//

import Foundation

/// Server-side bus/tram stop representation on map
struct MapStopResponse: Decodable {
    let seq: String
    let lat: String
    let lng: String
    let stopId: String
    let stopName: String
}
