//
//  MapData.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 26.10.2022.
//

import Foundation

/// Data to be shown on map
struct MapData {
    let vertices: [Vertex]
    let busList: [MapBus]
    let stopList: [MapStop]
}
