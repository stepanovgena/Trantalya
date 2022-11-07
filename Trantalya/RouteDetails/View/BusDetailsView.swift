//
//  BusDetailsView.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 26.10.2022.
//

import SwiftUI

struct BusDetailsView<DataProvider>: View where DataProvider: MapDataProviderProtocol {
    private var routeId: String
    private let stopId: String
    private let mapDataProvider: DataProvider
    
    init(
        routeId: String,
        stopId: String,
        mapDataProvider: DataProvider
    ) {
        self.routeId = routeId
        self.stopId = stopId
        self.mapDataProvider = mapDataProvider
    }
    
    var body: some View {
        BusMapView(mapDataProvider: mapDataProvider)
            .onAppear {
                mapDataProvider.startPolling(routeId: routeId, stopId: stopId)
            }
            .onDisappear {
                mapDataProvider.stopPolling()
            }
            .ignoresSafeArea()
    }
}

struct BusDetailsView_Previews: PreviewProvider {
    static var previews: some View {
       Text("foo")
    }
}
