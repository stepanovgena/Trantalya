//
//  RouteScheduleView.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 21.10.2022.
//

import SwiftUI

struct RouteScheduleView: View {
    let routeSchedule: RouteSchedule
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(12)
            VStack {
                HStack {
                    Text(routeSchedule.routeName)
                        .font(.headline)
                        .padding(.horizontal)
                    Spacer()
                }
                
                LazyVGrid(
                    columns: [
                        GridItem(),
                        GridItem(),
                        GridItem(),
                        GridItem(),
                        GridItem()
                    ]
                ) {
                    ForEach(routeSchedule.schedule, id: \.self) { schedule in
                        TimeTag(time: schedule)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }
}

struct RouteScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
            RouteScheduleView(routeSchedule:
                                RouteSchedule(
                                    routeName: "555",
                                    schedule: [
                                        "09:01",
                                        "09:02",
                                        "09:03",
                                        "09:04",
                                        "09:05",
                                        "09:06",
                                        "09:07",
                                        "09:08",
                                    ]
                                )
            )
        }
    }
}
