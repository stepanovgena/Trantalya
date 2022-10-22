//
//  TimeColorResolver.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 22.10.2022.
//

import Foundation

struct TimeColorResolver: TimeColorResolverProtocol {
    func getColorForTime(time: String, referenceDate: Date) -> TimeColor {
        let calendar = Calendar(identifier: .gregorian)
        let stringComponents = time.split(separator: ":")
        let hour = Int(stringComponents.first ?? "") ?? 0
        let minute = Int(stringComponents.last ?? "") ?? 0
      
        var refComponents = calendar.dateComponents([.year, .month, .day], from: referenceDate)
        refComponents.hour = hour
        refComponents.minute = minute
        let date = calendar.date(from: refComponents) ?? referenceDate
        
        return date >= referenceDate
        ? .future
        : .past
    }
}
