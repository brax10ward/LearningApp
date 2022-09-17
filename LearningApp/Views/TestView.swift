//
//  TestView.swift
//  LearningApp
//
//  Created by Braxton Ward on 9/16/22.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var isSubmitted = false
    
    var body: some View {
        if let currentQuestion = model.currentQuestion, let currentModule = model.currentModule {
            let questionCount = currentModule.test.questions.count
            let answers = currentQuestion.answers
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Question \(model.currentQuestionIndex + 1) of \(questionCount)")
                    
                    CodeTextView()
                }
                .padding()
                
                ScrollView {
                    VStack {
                        ForEach(0..<answers.count, id: \.self) { index in
                            let answer = answers[index]
                            let selectedAnswer = index == selectedAnswerIndex
                            
                            Button(action: { selectedAnswerIndex = index }) {
                                ZStack {
                                    if !isSubmitted {
                                        RectangleCard(color: selectedAnswer ? .gray : .white )
                                    } else {
                                        let isCorrectAnswer = index == currentQuestion.correctIndex
                                        
                                        RectangleCard(
                                            color: selectedAnswer ? isCorrectAnswer ? .green : .red
                                                : isCorrectAnswer ? .green : .white
                                        )
                                    }
                                    
                                    Text(answer)
                                        .bold()
                                        .foregroundColor(.black)
                                }
                            }
                            .disabled(isSubmitted)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                Button(action: {
                    isSubmitted = true
                    // Check the answer
                    if selectedAnswerIndex == currentQuestion.correctIndex {
                        numCorrect += 1
                    }
                }) {
                    ZStack {
                        RectangleCard(color: .green)
                        Text("Submit")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .padding()
                .disabled(isSubmitted || selectedAnswerIndex == nil)
                
                
            }
            .navigationBarTitle("\(currentModule.category) Test")
        } else {
            ProgressView()
        }
    }
}
