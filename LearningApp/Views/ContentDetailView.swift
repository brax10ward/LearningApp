//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Braxton Ward on 9/15/22.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        VStack {
            if let currentLesson = model.currentLesson {
                // MARK: VIDEO
                let videoUrl = URL(string: Constants.videoHostUrl + currentLesson.video)
                if let url = videoUrl {
                    VideoPlayer(player: AVPlayer(url: url))
                        .cornerRadius(10)
                        .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
                }
                
                // MARK: DESCRIPTION
                CodeTextView()
                
                // MARK: NEXT LESSON BUTTON
                if model.hasNextLesson() {
                    Button(action: { model.nextLesson() }) {
                        ZStack {
                            Rectangle()
                                .frame(height: 48)
                                .foregroundColor(.green)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            Text("Next Lesson: " + model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
            }
        }
        .navigationTitle(model.currentLesson?.title ?? "")
        .padding()
    }
}
