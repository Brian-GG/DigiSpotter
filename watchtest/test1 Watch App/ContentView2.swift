//
//  ContentView2.swift
//  test1 Watch App
//
//  Created by Brian Grigore on 2022-09-17.
//

import SwiftUI

struct ContentView2: View {
    var body: some View {
        
        VStack(
            alignment: .center,
                    spacing: 10

        )
        {
            HStack(
                alignment: .top,
                spacing: 51
            )
            {
                Text("REP")
                Text("SET")
            }
            HStack(
                alignment: .top,
                spacing: 10
            ) {
                Capsule()
                    .fill(.indigo)
                    .frame(width: 70, height: 45)
                    .overlay(Text("1").bold())
                Capsule()
                    .fill(.indigo)
                    .frame(width: 70, height: 45)
                    .overlay(Text("1").bold())
            }
            Capsule()
                .fill(.red)
                .frame(width: 150, height: 45)
                .overlay(Text("CANCEL").bold())
                .overlay(Button("") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                })
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
