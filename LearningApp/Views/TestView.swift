//
//  TestView.swift
//  LearningApp
//
//  Created by Braxton Ward on 9/16/22.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if let currentQuestion = model.currentQuestion, let currentModule = model.currentModule {
            let questionCount = currentModule.test.questions.count
            let answers = currentQuestion.answers
            
            VStack(alignment: .leading) {
                Text("Question \(model.currentQuestionIndex + 1) of \(questionCount)")
                
                CodeTextView()
                
                ForEach(0..<answers.count, id: \.self) { index in
                    let answer = answers[index]
                    
                    Button(action: {}) {
                        ZStack {
                            RectangleCard()
                            Text(answer)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("\(currentModule.category) Test")
        } else {
            ProgressView()
        }
    }
}
