//
//  ContentView.swift
//  LearningApp
//
//  Created by Braxton Ward on 9/15/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if let currentModule = model.currentModule {
                    ForEach(0..<currentModule.content.lessons.count, id: \.self) { index in
                        let lesson = currentModule.content.lessons[index]
                        
                        // MARK: LESSON CARD
                        ContentViewRow(lessonIndex: index)

                    }
                }
            }
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}
