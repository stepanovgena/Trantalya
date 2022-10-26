//
//  ScheduleResponse.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 20.10.2022.
//

import Foundation

struct ScheduleResponse: Decodable {
    let pathList: [PathlistResponse]
    let result: RequestResult
}

struct PathlistResponse: Decodable {
    let displayRouteCode: String
    let direction: RouteDirection
    let scheduleList: [Schedule]
}

struct RequestResult: Decodable {
    let cmd: String
    let code: Int
    let message: String
}
