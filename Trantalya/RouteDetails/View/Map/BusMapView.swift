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
    
    init(mapDataProvider: DataProvider) {
        self.mapDataProvider = mapDataProvider
    }
    
    func makeCoordinator() -> BusMapViewCoordinator {
        BusMapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        registerAnnotations(mapView: mapView)
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<BusMapView>) {
        updateOverlays(from: uiView)
    }
}
    
private extension BusMapView {
    func updateOverlays(from mapView: MKMapView) {
        let locations = mapDataProvider.mapData?.vertices.map {
            CLLocationCoordinate2D(
                latitude: Double($0.lat) ?? 36,
                longitude: Double($0.lng) ?? 30
            )
        } ?? []
        
        let edgeInsets = UIEdgeInsets(top: 30.0, left: 30.0, bottom: 30.0, right: 30.0)
        
        // draw route
        mapView.removeOverlays(mapView.overlays)
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        mapView.addOverlay(polyline)
        
        mapView.removeAnnotations(mapView.annotations)
        
        // draw stops
        let stops = mapDataProvider.mapData?.stopList.map {
            StopAnnotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: Double($0.lat) ?? 36,
                    longitude: Double($0.lng) ?? 30
                )
            )
        } ?? []
        mapView.addAnnotations(stops)
        
        // draw bus
        if let bus = mapDataProvider.mapData?.busList.first {
            let busPin = BusAnnotation()
            let coord = CLLocationCoordinate2D(
                latitude: Double(bus.lat) ?? 36,
                longitude: Double(bus.lng) ?? 30
            )
            busPin.coordinate = coord
            mapView.addAnnotation(busPin)
        }
        
        if !locations.isEmpty && mapDataProvider.zoomSetRequired {
            setMapZoomArea(
                map: mapView,
                polyline: polyline,
                edgeInsets: edgeInsets,
                animated: true
            )
        }
    }
    
    func setMapZoomArea(
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
    
    func registerAnnotations(mapView: MKMapView) {
        mapView.register(
            MKAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: NSStringFromClass(BusAnnotation.self)
        )
        mapView.register(
            MKAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: NSStringFromClass(StopAnnotation.self)
        )
    }
}

struct BusMapView_Previews: PreviewProvider {
    static var previews: some View {
        Text("foo")
    }
}
