//
//  ContentView.swift
//  HTNiPhoneFitnessApp
//
//  Created by Nicholas Abraham Sigurdsson on 2022-09-17.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    func login(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signup(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
}

struct FrontContent: View {
    @EnvironmentObject var  viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn{
                WorkoutSelection()
            }else{
                LoginPage()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct LoginPage: View {
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    @EnvironmentObject var  viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            VStack (spacing: 40) {
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 430, height: 390)
                TextField("Email", text: $textFieldEmail)
                    .frame(width: 175, height: 40)
                    .multilineTextAlignment(.center)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(16)
                SecureField("Password", text: $textFieldPassword)
                    .frame(width: 175, height: 40)
                    .multilineTextAlignment(.center)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(16)
                NavigationLink(destination: WorkoutSelection(), label: {
                  Text("Enter")
                    .frame(width: 100, height: 50)
                    .background(Color.white)
                    .foregroundColor(.black)
                    })
                
                NavigationLink("Create an Account",destination: CreateAccountPage())
                    .foregroundColor(.black)
                    .font(.subheadline)
                Spacer()
            }
            .navigationTitle("Login")
            .background(Color(UIColor(red: 76/255, green: 201/255, blue: 240/255, alpha: 1)))
        }
    }
}

struct CreateAccountPage: View {
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    @EnvironmentObject var  viewModel: AppViewModel
    
    var body: some View {
        VStack (spacing: 40) {
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 430, height: 390)
            TextField("Email", text: $textFieldEmail)
                .frame(width: 175, height: 40)
                .multilineTextAlignment(.center)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(16)
            SecureField("Password", text: $textFieldPassword)
                .frame(width: 175, height: 40)
                .multilineTextAlignment(.center)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(16)
            NavigationLink(destination: WorkoutSelection(), label: {
              Text("Enter")
                .frame(width: 100, height: 50)
                .background(Color.white)
                .foregroundColor(.black)
                })
            
            Spacer()
        }
        .navigationTitle("Create an Account")
        .background(Color(UIColor(red: 76/255, green: 201/255, blue: 240/255, alpha: 1)))
    }
}

struct Front_Previews: PreviewProvider {
    static var previews: some View {
        FrontContent()
    }
}
