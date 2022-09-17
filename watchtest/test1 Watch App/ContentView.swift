//
//  ContentView.swift
//  test1 Watch App
//
//  Created by Brian Grigore on 2022-09-17.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView() {
            
            
            
            ContentView2().tabItem {
                /*@START_MENU_TOKEN@*/Text("Tab Label 1")/*@END_MENU_TOKEN@*/ }.tag(1)
            
            
            
            ContentView3().tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 2")/*@END_MENU_TOKEN@*/ }.tag(2)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
