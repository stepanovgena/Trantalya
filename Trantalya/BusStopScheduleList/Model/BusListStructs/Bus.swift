//
//  Bus.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 17.10.2022.
//

import Foundation

/// Bus info
struct Bus: Decodable {
    let routeCode: String
    let displayRouteCode: String
    let displayName: String
    let headSign: String
}
