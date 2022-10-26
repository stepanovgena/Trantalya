//
//  Bus.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 17.10.2022.
//

import Foundation

struct Route: Decodable {
    let routeCode: String
    let displayRouteCode: String
    let name: String
    let headSign: String
}
