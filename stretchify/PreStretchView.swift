//
//  PreStretchView.swift
//  stretchify
//
//  Created by Sawyer Halverson on 4/23/24.
//

import SwiftUI

struct PreStretchView: View {
    let minutes: Int
    
    var body: some View {
        Text("You are stretching for \(minutes) minutes")
    }
}

struct PreStretchView_Previews: PreviewProvider {
    static var previews: some View {
        PreStretchView(minutes: 10) // Provide a value for the 'minutes' parameter
    }
}
