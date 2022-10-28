//
//  MapDataProviderProtocol.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 28.10.2022.
//

import Foundation
import CoreLocation

/// Obtaining data for map and bus info
protocol MapDataProviderProtocol: ObservableObject {
    var mapData: MapData? { get }
    func startPolling(routeId: String, stopId: String)
    func stopPolling()
}
