//
//  ScheduleResponse.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 20.10.2022.
//

import Foundation

/// Server response with schedule-related data
struct ScheduleResponse: Decodable {
    let pathList: [PathlistResponse]
    let result: RequestResult
}

/// Path info
struct PathlistResponse: Decodable {
    let displayRouteCode: String
    let direction: RouteDirection
    let scheduleList: [Schedule]
    let busList: [MapBus]
    let busStopList: [MapStopResponse]
    let pointList: [Vertex]
}

/// Request result info
struct RequestResult: Decodable {
    let cmd: String
    let code: Int
    let message: String
}
