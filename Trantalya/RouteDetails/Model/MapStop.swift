//
//  MapStop.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 26.10.2022.
//

import Foundation

/// Bus/tram stop representation on map
struct MapStop: Decodable {
    let seq: String
    let lat: String
    let lng: String
    let stopId: String
    let stopName: String
    let isSelected: Bool
}
