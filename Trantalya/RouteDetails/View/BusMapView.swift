//
//  BusMapView.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 26.10.2022.
//

import SwiftUI
import MapKit

struct BusMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 36.890056, longitude: 30.710049),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    var body: some View {
       Text("foo")
    }
}

struct BusMapView_Previews: PreviewProvider {
    static var previews: some View {
        BusMapView()
    }
}
