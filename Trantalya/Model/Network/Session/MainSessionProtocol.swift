//
//  MainSessionProtocol.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 16.10.2022.
//

import Foundation

protocol MainSessionProtocol {
    func getStopRoutes(id: String) async throws -> [Route]
    func getRouteSchedule(id: String) async throws -> RouteSchedule
}
