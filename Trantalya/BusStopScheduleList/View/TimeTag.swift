//
//  TimeTag.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 21.10.2022.
//

import SwiftUI

struct TimeTag: View {
    let time: String
    let colorResolver: TimeColorResolverProtocol
    var body: some View {
        ZStack {
            Rectangle()
                .fill(getColorForTime(time))
                .cornerRadius(12)
            Text(time)
        }
    }
    
    func getColorForTime(_ time: String) -> Color {
        let colorType = colorResolver.getColorForTime(time: time, referenceDate: Date.now)
        switch colorType {
        case .past:
            return .gray
        case .future:
            return .green
        }
    }
}

struct TimeTag_Previews: PreviewProvider {
    static var previews: some View {
        TimeTag(time: "10:15", colorResolver: TimeColorResolver())
    }
}
