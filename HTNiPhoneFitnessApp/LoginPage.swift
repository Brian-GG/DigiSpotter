//
//  ContentView.swift
//  HTNiPhoneFitnessApp
//
//  Created by Nicholas Abraham Sigurdsson on 2022-09-17.
//

import SwiftUI

struct LoginPage: View {
    @State var textFieldUsername : String=""
    @State var textFieldPassword : String=""
    
    var body: some View {
        NavigationView {
            VStack (spacing: 40) {
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 430, height: 390)
                Text("Enter your credentials")
                    .font(.headline)
                    .foregroundColor(.white)
                TextField("Username", text: $textFieldUsername)
                    .frame(width: 175, height: 40)
                    .multilineTextAlignment(.center)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(16)
                TextField("Password", text: $textFieldPassword)
                    .frame(width: 175, height: 40)
                    .multilineTextAlignment(.center)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(16)
                NavigationLink(destination: WorkoutSelection(), label: {
                    Text("Enter")
                        .frame(width: 100, height: 50)
                        .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                })
                Spacer()
            }
            .background(Color(UIColor(red: 76/255, green: 201/255, blue: 240/255, alpha: 1)))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
