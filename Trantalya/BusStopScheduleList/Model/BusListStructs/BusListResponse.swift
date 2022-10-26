//
//  BusListResponse.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 17.10.2022.
//

import Foundation

/// For some reason the server returns part of the routes as buses and part as routes
struct BusListResponse: Decodable {
    let routeList: [Route]
    let busList: [Bus]
}
