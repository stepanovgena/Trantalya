//
//  Schedule.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 20.10.2022.
//

import Foundation

struct Schedule: Decodable {
    let description: String
    let days: DayType
    let timeList: [Time]
    
    enum CodingKeys: String, CodingKey {
        case days = "serviceId"
        case description
        case timeList
    }

    enum DayType: String, Codable {
        case businessDays = "1"
        case saturday = "2"
        case sunday = "3"
    }
}
