//
//  ContentView.swift
//  MultiTables
//
//  Created by Peter Gabriel on 10.01.26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userChoiseTable = 2
    @State private var userRange = 5
    @State private var randomInt = Int.random(in: 1...12)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var userAnswer = 0
    @State private var numberOfQuestions = 0
    @State private var answeredQuestions = 0
    
    @State private var showingEnd = false
    @State private var endTitle = ""
    @State private var alertTxt = ""
    
    //@State private var test = 0
    
    let questionNumberArr = [5,10,20]
  
    @State private var answerArr = [0,0,0]
    

    
    var body: some View {
        
        Form {
           
            Text("\(randomInt) * \(userChoiseTable)").font(.title).frame(maxWidth: .infinity, alignment: .center)

            VStack{
                Text("Choose multiplication table")
                                            .font(.headline)
              
                                        
        Stepper("\(userChoiseTable) Table", value: $userChoiseTable, in: 2...12, step: 1)
            }
            
            VStack{
                Text("How many Questions?").font(.headline)
                
                Picker("Flavor", selection: $numberOfQuestions) {
                    ForEach(questionNumberArr, id: \.self) {
                        Text("\($0)")
                    }
                }.pickerStyle(.segmented)
                    .onChange(of: numberOfQuestions) {
                        answerArr = buildButtonArray()
                    }
                    .onChange(of: userChoiseTable) {
                        answerArr = buildButtonArray()
                    }
                    

            }
            
       
        }
        
        Text("Chose the correct answer")
            .font(.headline)
      
        
        HStack(spacing: 72) {
            ForEach(0..<3) {number in
                
                Button {
                    
                    buttonTapped(number)
                    
                }
                label: {
                    Text("\(answerArr[number])")
                }
                .frame(width: 60, height: 30)
                .foregroundStyle(.orange)
                .font(.title2)
                .background(Color.black)
                .clipShape(.capsule)
                .shadow(radius: 5)
                
            }
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: newQuestion)
        } message: {
            if userAnswer == randomInt * userChoiseTable {
                Text("\(alertTxt)")
            } else {
                Text("\(alertTxt)")
            }
        }
        
        .alert(endTitle, isPresented: $showingEnd) {
                    Button("Continue", action: newGame)
                } message: {
              Text("You have finished")
        }
        
        
    }
    
    func buttonTapped(_ number: Int) {
        
        let value = answerArr[number]
        
        if value == randomInt * userChoiseTable {
            showingScore = true
            alertTxt = "Correct"
            
        } else {
            showingScore = true
            alertTxt = "False"
        }
        
    }
    
    
  
    
    func buildButtonArray() -> Array<Int> {
        
        var sendArr = [Int]()
        sendArr.append(randomInt * userChoiseTable)
        sendArr.append(randomInt + 5 * 2)
        sendArr.append(userChoiseTable + 12)
        sendArr.shuffle()
        return sendArr
        
    }
    
   
    
    
    func newQuestion() {
        
        randomInt = Int.random(in: 1...12)
        answerArr = buildButtonArray()
        answeredQuestions += 1
        
        if numberOfQuestions == answeredQuestions {
            showingEnd = true
            endTitle = "This is the end"
        }
    }
    
    func newGame() {
        userAnswer = 0
        numberOfQuestions = 5
        answeredQuestions = 0
    
        
    }
    
}

#Preview {
    ContentView()
}
