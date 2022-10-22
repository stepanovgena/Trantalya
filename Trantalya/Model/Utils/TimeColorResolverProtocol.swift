//
//  TimeColorResolverProtocol.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 22.10.2022.
//

import Foundation

protocol TimeColorResolverProtocol {
    func getColorForTime(time: String, referenceDate: Date) -> TimeColor
}

enum TimeColor {
    case past
    case future
}
