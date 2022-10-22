//
//  TimeTag.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 21.10.2022.
//

import SwiftUI

struct TimeTag: View {
    let time: String
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.green)
                .cornerRadius(12)
            Text(time)
        }
    }
}

struct TimeTag_Previews: PreviewProvider {
    static var previews: some View {
        TimeTag(time: "10:15")
    }
}
