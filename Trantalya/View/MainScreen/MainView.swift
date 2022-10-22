//
//  ContentView.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 16.10.2022.
//

import SwiftUI

struct MainView: View {
    @State private var busStopInput = ""
    @State private var routes = [Route]()
    @State private var routeSchedules = [RouteSchedule]()

    var body: some View {
        VStack {
            ScrollView{
                ForEach(routeSchedules, id: \.routeName) {
                    RouteScheduleView(routeSchedule: $0)
                }
            }
            Spacer()
            Divider()
            HStack {
                TextField(
                    "Input your stop ID",
                    text: $busStopInput
                )
                .padding()
                .keyboardType(.numberPad)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    loadData(stopId: busStopInput)
                }
                Button("Submit") {
                    loadData(stopId: busStopInput)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .padding(.vertical)
                .tint(.primary)
            }
            .padding()
        }
    }
    
    func loadData(stopId: String) {
        let session = MainSession(
            session: URLSession.shared,
            urlFactory: UrlFactory()
        )
            Task {
            do {
                let routes = try await session.getStopRoutes(id: stopId)
                try await withThrowingTaskGroup(of: RouteSchedule.self, body: { group in
                    for route in routes {
                        group.addTask {
                            let routeSchedule = try await session.getRouteSchedule(id: route.displayRouteCode)
                            return routeSchedule
                        }
                    }
                    for try await routeSchedule in group {
                        routeSchedules.append(
                            routeSchedule
                        )
                    }
                })
            }
            catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
