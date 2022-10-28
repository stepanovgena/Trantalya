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
    @State private var selectedDayType: DayType = .businessDays
    @FocusState private var isInputFocused: Bool
    private let timeColorResolver = TimeColorResolver()
    private let session = MainSession(
        session: URLSession.shared,
        urlFactory: UrlFactory()
    )
   
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
                    
                    ForEach(routeSchedules, id: \.routeName) { schedule in
                        NavigationLink (destination:
                                            BusDetailsView(
                                                routeId: schedule.routeName,
                                                stopId: busStopInput,
                                                mapDataProvider: MapDataProvider(
                                                    session: session,
                                                    pollingInterval: 5
                                                )
                                            )
                        ) {
                            RouteScheduleView(
                                routeSchedule:
                                    RouteSingleSchedule(
                                        name: schedule.routeName,
                                        times: schedule.schedule[selectedDayType] ?? []
                                    ),
                                timeColorResolver: timeColorResolver
                            )
                        }
                        .foregroundColor(.primary)
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
