//
//  TestResultView.swift
//  LearningApp
//
//  Created by Braxton Ward on 9/16/22.
//

import SwiftUI

struct TestResultView: View {
    @EnvironmentObject var model: ContentModel
    var numOfCorrectionQuestions: Int
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(resultHeading)
                .font(.title)
            
            Spacer()
            
            if let currentModule = model.currentModule {
                let questionCount = currentModule.test.questions.count
                Text("You got \(numOfCorrectionQuestions) out of \(questionCount) questions correct.")
            }
            
            Spacer()
            
            Button {
                model.currentTestSelected = nil
            } label: {
                ZStack {
                    RectangleCard(color: .green)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding()
            
            Spacer()
        }
    }
    
    var resultHeading: String {
        if let currentModule = model.currentModule {
            let pct = Double(numOfCorrectionQuestions) / Double(currentModule.test.questions.count)
            
            if pct > 0.5 {
                return "Awesome!"
            } else if pct > 0.2 {
                return "Doing great!"
            } else {
                return "Keep learning."
            }
        } else {
            return "Results"
        }
    }
}
