//
//  BusMapView.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 26.10.2022.
//

import SwiftUI
import MapKit

struct BusMapView<DataProvider>: UIViewRepresentable where DataProvider: MapDataProviderProtocol {
    @ObservedObject private var mapDataProvider: DataProvider
    @State private var zoomSet = false
    
    init(mapDataProvider: DataProvider) {
        self.mapDataProvider = mapDataProvider
    }
    
    func makeCoordinator() -> BusMapViewCoordinator {
        BusMapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<BusMapView>) {
        updateOverlays(from: uiView)
    }
    
    private func updateOverlays(from mapView: MKMapView) {
        let locations = mapDataProvider.mapData?.vertices.map {
            CLLocationCoordinate2D(
                latitude: Double($0.lat) ?? 36,
                longitude: Double($0.lng) ?? 30
            )
        } ?? []
        
        let edgeInsets = UIEdgeInsets(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
        
        mapView.removeOverlays(mapView.overlays)
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        mapView.addOverlay(polyline)
        mapView.removeAnnotations(mapView.annotations)
        
        let busPin = MKPointAnnotation()
        let bus = mapDataProvider.mapData?.busList.first
        let coord = CLLocationCoordinate2D(
            latitude: Double(bus?.lat ?? "") ?? 36,
            longitude: Double(bus?.lng ?? "") ?? 30
        )
        
        busPin.coordinate = coord
        mapView.addAnnotation(busPin)
        
        if !locations.isEmpty && !zoomSet {
            zoomSet = true
            setMapZoomArea(
                map: mapView,
                polyline: polyline,
                edgeInsets: edgeInsets,
                animated: true
            )
        }
    }
        
    private func setMapZoomArea(
        map: MKMapView,
        polyline: MKPolyline,
        edgeInsets: UIEdgeInsets,
        animated: Bool = false
    ) {
        map.setVisibleMapRect(
            polyline.boundingMapRect,
            edgePadding: edgeInsets,
            animated: animated
        )
    }
}

struct BusMapView_Previews: PreviewProvider {
    static var previews: some View {
        Text("foo")
    }
}
