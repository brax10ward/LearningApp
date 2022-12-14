//
//  HomeView.swift
//  LearningApp
//
//  Created by Braxton Ward on 9/15/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            VStack (alignment: .leading) {
                
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) { module in
                            VStack (spacing: 20) {
                                // MARK: LEARNING CARD
                                NavigationLink (
                                    destination: ContentView()
                                        .onAppear {
                                            model.beginModule(module.id)
                                        },
                                    tag: module.id,
                                    selection: $model.currentSelectedContent,
                                    label:{
                                        HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                        
                                    }
                                )
                                
                                // MARK: TEST CARD
                                NavigationLink(
                                    destination: TestView()
                                        .onAppear {
                                            model.beginTest(module.id)
                                        },
                                    tag: module.id,
                                    selection: $model.currentTestSelected,
                                    label: {
                                        HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
                                    }
                                )
                            }
                            .accentColor(.black)
                            .padding(.bottom, 10)
                        }
                    }
                    .padding()
                }
                
            }
            .navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
