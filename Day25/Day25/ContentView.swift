//
//  ContentView.swift
//  Day25
//
//  Created by Anzhellika Sokolova on 09.01.2021.
//

import SwiftUI



struct ContentView: View {
    
    @State private var moves = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var appChoiceAction = Int.random(in: 0...2)
    @State private var appWinOrLose = Bool.random()
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreCount = 0
    @State private var attemptNumber = 1

    
    func moveTapped(_ number: Int) {
              
        if moves[appChoiceAction]=="Rock" {
            if appWinOrLose==true {
                if moves[number]=="Paper" {
                    scoreTitle="Correct"
                    scoreCount+=1
                } else  {
                    scoreTitle="Wrong"
                    scoreCount-=1
                }
            } else {
                if moves[number]=="Scissors" {
                    scoreTitle="Correct"
                    scoreCount+=1
                } else  {
                    scoreTitle="Wrong"
                    scoreCount-=1
                }
            }
        }
        
  if moves[appChoiceAction]=="Paper" {
      if appWinOrLose==true {
          if moves[number]=="Scissors" {
              scoreTitle="Correct"
              scoreCount+=1
          } else  {
              scoreTitle="Wrong"
              scoreCount-=1
          }
      } else {
          if moves[number]=="Rock" {
              scoreTitle="Correct"
              scoreCount+=1
          } else  {
              scoreTitle="Wrong"
              scoreCount-=1
          }
      }
  }
 
        
  if moves[appChoiceAction]=="Scissors" {
      if appWinOrLose==true {
          if moves[number]=="Rock" {
              scoreTitle="Correct"
              scoreCount+=1
          } else  {
              scoreTitle="Wrong"
              scoreCount-=1
          }
      } else {
          if moves[number]=="Paper" {
              scoreTitle="Correct"
              scoreCount+=1
          } else  {
              scoreTitle="Wrong"
              scoreCount-=1
          }
      }
  }
        
        if scoreCount<0 {scoreCount=0}
        
        showingScore = true
        
        if attemptNumber<10 {
            attemptNumber+=1}
        else {
            attemptNumber=1
            scoreCount=0
        }
    }
    
    func askQuestion() {
        moves.shuffle()
        appChoiceAction = Int.random(in: 0...2)
        appWinOrLose = Bool.random()
    }
    
    var body: some View {
        
        
        ZStack{
             VStack (spacing: 30){
                VStack{
                //   Text("\(appChoiceAction)")
                Text(moves[appChoiceAction])
                appWinOrLose ? Text("win") : Text("lose")
            }
            .font(.largeTitle)
            .foregroundColor(.black)

            ForEach(0 ..< 3) { number in
                Button(action: {
                    self.moveTapped(number)
                }) {
                 //   Text("\(number)")
                    Text(self.moves[number])
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            Text("Score: \(scoreCount)")
                .foregroundColor(.black)
                .font(.largeTitle)
            Text("Question: \(attemptNumber)/10")
                    .foregroundColor(.green)
                    .font(.largeTitle)
            //Spacer()
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
