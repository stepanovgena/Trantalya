//
//  BusListErrorView.swift
//  Trantalya
//
//  Created by Gennady Stepanov on 02.11.2022.
//

import SwiftUI

fileprivate enum Constants {
    static var errorText: String {
        "Something went wrong. Please try again."
    }
}

/// Error state view for buslist
struct BusListErrorView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.octagon")
                .foregroundColor(.secondary)
                .font(.system(size: 65))
                .padding(.bottom)
            Text(Constants.errorText)
        }
    }
}

struct BusListErrorView_Previews: PreviewProvider {
    static var previews: some View {
        BusListErrorView()
    }
}
