//
//  WorkoutSelection.swift
//  HTNiPhoneFitnessApp
//
//  Created by Nicholas Abraham Sigurdsson on 2022-09-17.
//

import SwiftUI
struct WorkoutSelection: View {
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 20){
                HStack (spacing: 50){
                    NavigationLink("Parameters",destination: Parameter())
                        .foregroundColor(.black)
                        .font(.subheadline)
                    NavigationLink("Historical",destination: Historical())
                        .foregroundColor(.black)
                        .font(.subheadline)
                    NavigationLink("Analysis",destination: Analysis())
                        .foregroundColor(.black)
                        .font(.subheadline)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Workout Selection")
                            .font(.largeTitle.bold())
                            .accessibilityAddTraits(.isHeader)
                            .foregroundColor(.black)
                    }
                }
                VStack (spacing: 20){
                    Image("squat")
                        .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    Text("Squats")
                        .foregroundColor(.black)
                        .font(.subheadline)
                    Text("Focus: Gluteus, Quadriceps, Calves")
                        .foregroundColor(.black)
                        .font(.subheadline)
                }
            }
        }
    }
}
struct Parameter: View{
    @State var textFieldReps : String=""
    @State var textFieldSets : String=""
    @State var textFieldRest : String=""
    
    var body: some View{
        VStack (spacing: 15){
            Text("# of Reps")
            TextField("Reps", text: $textFieldReps)
                .multilineTextAlignment(.center)
            Text("# of Set")
            TextField("Sets", text: $textFieldSets)
                .multilineTextAlignment(.center)
            Text("Rest Time")
            TextField("Rest Time", text: $textFieldRest)
                .multilineTextAlignment(.center)
            Button("Enter"){
            }
        }
    }
}

struct Historical: View{
    var body: some View{
        Text("Historical")
    }
}

struct Analysis: View{
    var body: some View{
        Text("Analysis")
    }
}

struct WorkoutSelection_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSelection()
    }
}

