//
//  ContentModel.swift
//  LearningApp
//
//  Created by Braxton Ward on 9/15/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    // App state
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    // MARK: DATA METHODS
    func getLocalData() {
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            let jsonDecoder = JSONDecoder()
            
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            self.modules = modules
            
            
        } catch {
            print(error)
        }
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
            
        } catch {
            print(error)
        }
    }
    
    // MARK: MODULE NAV METHODS
    func beginModule(_ moduleId: Int) {
        if let moduleIndex = modules.firstIndex(where: {$0.id == moduleId}) {
            self.currentModuleIndex = moduleIndex
        }
        
        self.currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonId: Int) {
        if let lessonIndex = currentModule?.content.lessons.firstIndex(where: {$0.id == lessonId}) {
            self.currentLessonIndex = lessonIndex
        }
        
        self.currentLesson = modules[currentModuleIndex].content.lessons[currentLessonIndex]
    }
    
    func hasNextLesson() -> Bool {
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
    }
    
    func nextLesson() {
        // Advance the lesson
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        } else {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
}
