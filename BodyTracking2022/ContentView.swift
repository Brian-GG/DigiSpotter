//
//  ContentView.swift
//  BodyTracking2022
//
//  Created by Kareem Ghadban on 2022-09-17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
