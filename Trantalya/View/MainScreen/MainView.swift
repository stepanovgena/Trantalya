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
    
    var body: some View {
        VStack {
            List(routes, id: \.displayRouteCode) { route in
                Text(route.displayRouteCode)
                    .font(.headline)
            }
            .listStyle(.plain)
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
                routes = try await session.getStopRoutes(id: stopId)
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
