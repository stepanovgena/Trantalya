//
//  MainSession.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 16.10.2022.
//

import Foundation

final class MainSession: MainSessionProtocol {
    private let session: URLSession
    private let urlFactory: UrlFactoryProtocol
    
    init(session: URLSession, urlFactory: UrlFactoryProtocol) {
        self.session = session
        self.urlFactory = urlFactory
    }
    
    func getStopRoutes(id: String) async throws -> [Route] {
        let params = makeDefaultParams() +
        [
            ("busStopId", id)
        ]
        guard let url = urlFactory.makeUrl(
            pathComponent: "bus/closest",
            params: params
        ) else {
            throw NetworkError.urlError
        }
        let request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 30
        )
        let (data, response) = try await session.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.responseCodeError
        }
        let decoder = JSONDecoder()
        let busListResponse = try decoder.decode(BusListResponse.self, from: data)
        let routes = busListResponse.routeList
        + busListResponse.busList.map {
            Route(
                routeCode: $0.routeCode,
                displayRouteCode: $0.displayRouteCode,
                name: $0.displayName,
                headSign: $0.headSign
            )
        }
        print(routes.map { $0.displayRouteCode })
        return routes
    }
    
    func getRouteSchedule(routeId: String, stopId: String) async throws -> RouteSchedule {
        let params = makeDefaultParams() +
        [
            ("displayRouteCode", routeId),
            ("busStopId", stopId)
        ]
        guard let url = urlFactory.makeUrl(
            pathComponent: "v2.0/route/info",
            params: params
        ) else {
            throw NetworkError.urlError
        }
        let request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 30
        )
        let (data, response) = try await session.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.responseCodeError
        }
        let decoder = JSONDecoder()
        let scheduleResponse = try decoder.decode(ScheduleResponse.self, from: data)
        let routeName = scheduleResponse.pathList.first?.displayRouteCode ?? ""
        
        let schedules = scheduleResponse.pathList
            .flatMap { $0.scheduleList }
        var outputSchedule = [DayType: [String]]()
        schedules.forEach {
            let dayType = $0.days
            let times = $0.timeList.map {
                $0.departureTime.split(separator: ":").prefix(2).joined(separator: ":")
            }
            var value = outputSchedule[dayType] ?? []
            value.append(contentsOf: times)
            outputSchedule[dayType] = value
        }
        
        return RouteSchedule(
            routeName: routeName,
            schedule: outputSchedule
        )
    }
}

private extension MainSession {
    func makeDefaultParams() -> [(String, String)] {
        [
            ("accuracy", "0"),
            ("authType", "0"),
            ("lang", "tr"),
            ("lat", "0"),
            ("lng", "0"),
            ("nfcSupport", "0"),
            ("region", "026"),
        ]
    }
}

enum NetworkError: String, Error {
    case urlError
    case responseCodeError
}

protocol UrlFactoryProtocol {
    func makeUrl(
        pathComponent: String,
        params: [(name: String, value: String)]
    ) -> URL?
}

struct UrlFactory: UrlFactoryProtocol {
    func makeUrl(
        pathComponent: String,
        params: [(name: String, value: String)]
    ) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "service.kentkart.com"
        components.path = "/rl1/api/" + pathComponent
        components.queryItems = params.map {
            URLQueryItem(
                name: $0.name,
                value: $0.value
            )
        }
        return components.url
    }
}
