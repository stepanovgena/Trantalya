//
//  MapDataProvider.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 28.10.2022.
//

import Foundation
import CoreLocation

/// Obtains data for map and bus info
final class MapDataProvider: MapDataProviderProtocol {
    @Published var mapData: MapData?
    var zoomSetRequired: Bool {
        if zoomUpdateCounter > 0 {
            zoomUpdateCounter -= 1
            return true
        } else {
            return false
        }
    }
    private var zoomUpdateCounter = 1
    private var timer: Timer?
    private let session: MainSessionProtocol
    private let pollingInterval: TimeInterval
    
    init(
        session: MainSessionProtocol,
        pollingInterval: TimeInterval
    ) {
        self.session = session
        self.pollingInterval = pollingInterval
    }
    
    func startPolling(routeId: String, stopId: String) {
        timer = Timer.scheduledTimer(
            withTimeInterval: pollingInterval,
            repeats: true,
            block: { [weak self] timer in
                guard let self = self else { return }
                
                Task.detached {
                    do {
                        let fetchedMapData = try await self.session.getMapData(routeId: routeId, stopId: "")
                        let result = fetchedMapData.filter {
                            $0.stopList.contains {
                                $0.stopId == stopId
                            }
                        }.first
                        await MainActor.run {
                            self.mapData = result
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        )
    }
    
    func stopPolling() {
        timer?.invalidate()
        timer = nil
    }
}
