//
//  BaseSkeletonView.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 22.10.2022.
//

import SwiftUI
import SkeletonUI

struct BaseSkeletonView: View {
    var body: some View {
        Rectangle()
            .skeleton(with: true)
            .shape(type: .rounded(.radius(12, style: .circular)))
    }
}

struct BaseSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        BaseSkeletonView()
    }
}
