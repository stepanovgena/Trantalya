//
//  BusDetailsViewTests.swift
//  TrantalyaTests
//
//  Created by Gennady Stepanov on 07.11.2022.
//

import XCTest
import ViewInspector
@testable import Trantalya

class BusDetailsViewTests: XCTestCase {
    fileprivate var busDetailsView: BusDetailsView<MapDataProviderMock>!
    fileprivate var mapDataProviderMock: MapDataProviderMock!
    let routeId = "foo"
    let stopId = "bar"

    override func setUp() {
        mapDataProviderMock = MapDataProviderMock()
        busDetailsView = BusDetailsView(
            routeId: routeId,
            stopId: stopId,
            mapDataProvider: mapDataProviderMock
        )
    }
    
    func testThatPollingStarts() {
        mapDataProviderMock.pollingStarted = false
        mapDataProviderMock.pollingRouteId = ""
        mapDataProviderMock.pollingStopId = ""
        let mapView = try! busDetailsView
            .inspect()
            .find(BusMapView<MapDataProviderMock>.self)
        try! mapView.callOnAppear()
        XCTAssertTrue(mapDataProviderMock.pollingStarted)
        XCTAssertEqual(mapDataProviderMock.pollingRouteId, routeId)
        XCTAssertEqual(mapDataProviderMock.pollingStopId, stopId)
    }
    
    func testThatPollingStops() {
        mapDataProviderMock.pollingStopped = false
        let mapView = try! busDetailsView
            .inspect()
            .find(BusMapView<MapDataProviderMock>.self)
        try! mapView.callOnDisappear()
        XCTAssertTrue(mapDataProviderMock.pollingStopped)
    }
}

private extension BusDetailsViewTests {
    final class MapDataProviderMock: MapDataProviderProtocol {
        var pollingStarted = false
        var pollingStopped = false
        var pollingRouteId = ""
        var pollingStopId = ""
        
        var mapData: MapData? = MapData(vertices: [], busList: [], stopList: [])
        var zoomSetRequired: Bool = false
        
        func startPolling(routeId: String, stopId: String) {
            pollingRouteId = routeId
            pollingStopId = stopId
            pollingStarted = true
        }
        
        func stopPolling() {
            pollingStopped = true
        }
    }
}
