//
//  DayType.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 26.10.2022.
//

import Foundation

/// Signifies type of schedule based on week day
enum DayType: String, Codable, CaseIterable {
    case businessDays = "1"
    case saturday = "2"
    case sunday = "3"
    
    var stringValue: String {
        switch self {
        case .businessDays: return "Mon - Fri"
        case .saturday: return "Sat"
        case .sunday: return "Sun"
        }
    }
}
