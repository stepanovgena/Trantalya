//
//  Schedule.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 20.10.2022.
//

import Foundation

/// Schedule info
struct Schedule: Decodable {
    let description: String
    let days: DayType
    let timeList: [Time]
    
    enum CodingKeys: String, CodingKey {
        case days = "serviceId"
        case description
        case timeList
    }
}
