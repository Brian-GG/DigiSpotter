//
//  ContentView3.swift
//  test1 Watch App
//
//  Created by Brian Grigore on 2022-09-17.
//

import SwiftUI

struct ContentView3: View {
    @State var timeRemaining = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("\(timeRemaining)")
            .font(.system(.title, design: .rounded))
            .foregroundColor(.orange)
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    if timeRemaining == 0 {
                        timeRemaining = 10
                    }
                    
                }
            }
        //        Text("125").font(.system(.title, design: .rounded)).foregroundColor(.orange)
    }
}

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}
