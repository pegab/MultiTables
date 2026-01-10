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
    
    @State private var test = 0
    
    let questionNumberArr = [5,10,20]
    
    var body: some View {
        
        Form {
           
            Text("What is \(randomInt) * \(userChoiseTable)").font(.headline)
                TextField(
                    "Enter the result",
                    value: $userAnswer,
                    format: .number
                ).onSubmit {
                    showingScore = true
                }
            
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

            }
            
            Button("\(randomInt * userChoiseTable)") {
                // code action to come
            }
            
            
            
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: newQuestion)
        } message: {
            if userAnswer == randomInt * userChoiseTable {
                Text("Correct")
            } else {
                Text("False")
            }
        }
        
        .alert(endTitle, isPresented: $showingEnd) {
                    Button("Continue", action: newGame)
                } message: {
              Text("You have finished")
        }
        
        
    }
    
   
    

    
    func newQuestion() {
        
        randomInt = Int.random(in: 1...12)
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
