//
//  ScheduleSkeletonView.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 22.10.2022.
//

import SwiftUI
import SkeletonUI

struct ScheduleSkeletonView: View {
    var body: some View {
        BaseSkeletonView()
            .frame(height: 150)
            .padding()
        BaseSkeletonView()
            .frame(height: 100)
            .padding()
        BaseSkeletonView()
            .frame(height: 130)
            .padding()
        BaseSkeletonView()
            .frame(height: 90)
            .padding()
        BaseSkeletonView()
            .frame(height: 150)
            .padding()
    }
}

struct ScheduleSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleSkeletonView()
    }
}
