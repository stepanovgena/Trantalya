//
//  ContentView.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 16.10.2022.
//

import SwiftUI

struct BusStopScheduleList: View {
    @State private var busStopInput = ""
    @State private var routes = [Route]()
    @State private var routeSchedules = [RouteSchedule]()
    @State private var isLoading = false
    private let timeColorResolver = TimeColorResolver()
    @State private var selectedDayType: DayType = .businessDays
    @FocusState private var isInputFocused: Bool
   
    var body: some View {
        NavigationView {
        VStack {
            ScrollView{
                if routeSchedules.isEmpty && isLoading {
                    ScheduleSkeletonView()
                } else {
                    Picker("Day of week", selection: $selectedDayType) {
                        ForEach(DayType.allCases, id: \.self) {
                            Text($0.stringValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    ForEach(routeSchedules, id: \.routeName) {
                        RouteScheduleView(
                            routeSchedule:
                                RouteSingleSchedule(
                                    name: $0.routeName,
                                    times: $0.schedule[selectedDayType] ?? []
                                ),
                            timeColorResolver: timeColorResolver
                        )
                    }
                }
            }
            Spacer()
            Divider()
            HStack {
                TextField(
                    "Input your stop ID",
                    text: $busStopInput
                )
                .focused($isInputFocused)
                .padding()
                .keyboardType(.numberPad)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    isInputFocused = false
                    loadData(stopId: busStopInput)
                }
                Button("Submit") {
                    isInputFocused = false
                    loadData(stopId: busStopInput)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .padding(.vertical)
                .tint(.primary)
            }
            .padding()
        }
        .navigationTitle("Schedule")
        .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func loadData(stopId: String) {
        isLoading = true
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
                            let routeSchedule = try await session.getRouteSchedule(
                                routeId: route.displayRouteCode,
                                stopId: stopId
                            )
                            return routeSchedule
                        }
                    }
                    routeSchedules = []
                    var tempRouteSchedules = [RouteSchedule]()
                    for try await routeSchedule in group {
                        tempRouteSchedules.append(
                            routeSchedule
                        )
                    }
                    isLoading = false
                    routeSchedules = tempRouteSchedules.sorted(by: { $0.routeName < $1.routeName })
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
        BusStopScheduleList()
    }
}
