//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anzhellika Sokolova on 06.01.2021.
//

import SwiftUI

struct FlagImage: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreCount = 0
    
    @State private var animationAmount = 0.0
    @State private var flagIsWrong = [1.0,1.0,1.0]
    @State private var arrayAmount = [0.0, 0.0, 0.0]
    @State private var arrayWrongFlags = [1,1,1]
    @State private var shakeAnimation = [0,0,0]

    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            withAnimation {
                self.arrayWrongFlags = [3,3,3]
                self.arrayWrongFlags[number] = 1
            }
            withAnimation{//}(.interpolatingSpring(stiffness: 3, damping: 6)) {
                self.arrayAmount[number] += 360
            }
            scoreTitle = "Correct!"
            scoreCount+=1
        } else {
            withAnimation {
                self.flagIsWrong[number] = 1.5
              //  self.shakeAnimation[number] = -30
            }
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        //self.askQuestion()
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        arrayWrongFlags = [1,1,1]
        flagIsWrong = [1.0,1.0,1.0]
       // shakeAnimation = [0,0,0]
    }
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack (spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)

                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
            
             /*   ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }){
                        
                        Image(self.countries[number])
                            .modifier(FlagImage())
                    }
                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                 }*/
                    Button(action: {
                        self.flagTapped(0)
                    }){
                        
                        Image(self.countries[0])
                            .modifier(FlagImage())
                    }
                    .rotation3DEffect(.degrees(arrayAmount[0]), axis: (x: 0, y: 1, z: 0))
                    .blur(radius: CGFloat((arrayWrongFlags[0] - 1) * 3))
                    .scaleEffect(CGFloat(flagIsWrong[0]))
                    //.offset(x: CGFloat(shakeAnimation[0]))
                  //  .animation(Animation.default.repeatCount(4).speed(3))
                   // .animation//.easeInOut(duration: 1))

                
                    Button(action: {
                        self.flagTapped(1)
                    }){
                        
                        Image(self.countries[1])
                            .modifier(FlagImage())
                    }
                    .rotation3DEffect(.degrees(arrayAmount[1]), axis: (x: 0, y: 1, z: 0))
                    .blur(radius: CGFloat((arrayWrongFlags[1] - 1) * 3))
                    //.offset(x: CGFloat(shakeAnimation[1]))
                   // .animation(Animation.default.repeatCount(4).speed(3))
                    .scaleEffect(CGFloat(flagIsWrong[1]))
                  //  .animation//.easeInOut(duration: 1))

                    Button(action: {
                        self.flagTapped(2)
                    }){
                        
                        Image(self.countries[2])
                            .modifier(FlagImage())
                    }
                    .rotation3DEffect(.degrees(arrayAmount[2]), axis: (x: 0, y: 1, z: 0))
                    .blur(radius: CGFloat((arrayWrongFlags[2] - 1) * 3))
                    .scaleEffect(CGFloat(flagIsWrong[2]))
                  //  .offset(x: CGFloat(shakeAnimation[2]))
                   // .animation(Animation.default.repeatCount(4).speed(3))
                  //         .animation//.easeInOut(duration: 1))
                
                Text("Score: \(scoreCount)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                Spacer()
            }
            
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(scoreCount)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
