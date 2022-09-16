//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by Braxton Ward on 9/15/22.
//

import SwiftUI

struct ContentViewRow: View {
    @EnvironmentObject var model: ContentModel
    var lessonIndex: Int
    
    var body: some View {
        if let currentModule = model.currentModule {
            let lesson = currentModule.content.lessons[lessonIndex]
            let lessonNumber = String(lessonIndex + 1)
            let lessonTitle = lesson.title
            let lessonDuration = lesson.duration
            
            ZStack (alignment: .leading) {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(height: 66)
                
                HStack (spacing: 30) {
                    Text(lessonNumber)
                        .font(.title)
                        .bold()
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(lessonTitle)
                            .font(.headline)
                            .bold()
                        Text(lessonDuration)
                            .font(.subheadline)
                    }
                }
                .padding()
            }
            .padding(.bottom, 3)
        }
        
    }
}
