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
        VStack (spacing:40){
            VStack (spacing: 15){
                Text("September 17, 2022")
                HStack (spacing: 10){
                    VStack{
                        Text("Start Time")
                        Text("19:15")
                    }
                    VStack{
                        Text("End Time")
                        Text("20:15")
                    }
                    VStack{
                        Text("Rest Time")
                        Text("0:15")
                    }
                    VStack{
                        Text("# of Rep")
                        Text("14")
                    }
                }
                HStack (spacing: 15){
                    VStack{
                        Text("# of Sets")
                        Text("15")
                    }
                    VStack{
                        Text("Leg Posture")
                        Text("Good")
                    }
                    VStack{
                        Text("Back Posture")
                        Text("Excellent")
                    }
                }
            }
            VStack (spacing: 15){
                Text("September 18, 2022")
                HStack (spacing: 10){
                    VStack{
                        Text("Start Time")
                        Text("23:55")
                    }
                    VStack{
                        Text("End Time")
                        Text("24:15")
                    }
                    VStack{
                        Text("Rest Time")
                        Text("0:10")
                    }
                    VStack{
                        Text("# of Rep")
                        Text("12")
                    }
                }
                HStack (spacing: 10){
                    VStack{
                        Text("# of Sets")
                        Text("11")
                    }
                    VStack{
                        Text("Leg Posture")
                        Text("Excellent")
                    }
                    VStack{
                        Text("Back Posture")
                        Text("Excellent")
                    }
                }
            }
        }
    }
}

struct Analysis: View{
    var body: some View{
        Text("")
        
    }
}

struct WorkoutSelection_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSelection()
    }
}

struct WorkoutSummary: View{
    @State var number = 100 //connect this to whatever you're getting from the userform
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View{
        Text("Rest Timer\n\(number)")
            .font(.system(size:30))
            .multilineTextAlignment(.center)
            .padding()
            .onReceive(timer) { _ in
                if number > 0 {
                    number -= 1
                }
            }
    }
}

          
