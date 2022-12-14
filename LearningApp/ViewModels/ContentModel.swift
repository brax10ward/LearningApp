//
//  ContentModel.swift
//  LearningApp
//
//  Created by Braxton Ward on 9/15/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    // MARK: APP STATE
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    @Published var currentSelectedContent: Int?
    @Published var currentTestSelected: Int?
    
    init() {
        getLocalData()
        getRemoteData()
    }
    
    // MARK: DATA METHODS
    func getLocalData() {
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            let jsonDecoder = JSONDecoder()
            
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            self.modules += modules
            
            
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
    
    func getRemoteData() {
        let urlString = Constants.dataHostUrl + "data2.json"
        
        let hostURL = URL(string: urlString)
        
        if let url = hostURL {
            let request = URLRequest(url: url)
            
            let session = URLSession.shared
            session.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error getting remote data")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let modules = try decoder.decode([Module].self, from: data!)
                    self.modules += modules
                } catch {
                    print("Error decoding remote JSON file")
                }
            }
            .resume()
        }
        
        
    }
    
    // MARK: LESSON METHODS
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
        self.codeText = self.addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        // Advance the lesson
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            self.codeText = self.addStyling(currentLesson!.explanation)
        } else {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        return currentLessonIndex + 1 < currentModule!.content.lessons.count
    }
    
    // MARK: TEST METHODS
    func beginTest(_ moduleId: Int) {
        beginModule(moduleId)
        
        // Set the current question
        currentQuestionIndex = 0
        
        if currentModule?.test.questions.count ?? 0 > 0 {
            self.currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            self.codeText = self.addStyling(currentQuestion!.content)
        }
    }
    
    func nextTestQuestion() {
        currentQuestionIndex += 1
        
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        } else {
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    func hasNextQuestion() -> Bool {
        return currentQuestionIndex + 1 < currentModule!.test.questions.count
    }
    
    // MARK: CODE STYLING METHODS
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add the styling data
        if let styles = styleData {
            data.append(styles)
        }
        
        // Add the html data
        data.append(Data(htmlString.utf8))
        
        // Convert the attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        } else {
            print("Couldn't parse html")
        }
        
        
        return resultString
    }
}
