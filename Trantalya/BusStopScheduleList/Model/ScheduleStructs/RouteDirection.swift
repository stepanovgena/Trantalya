//
//  RouteDirection.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 26.10.2022.
//

import Foundation

/// Route direction from A to B or from B to A
enum RouteDirection: String, Decodable {
    case forward = "0"
    case reverse = "1"
}
