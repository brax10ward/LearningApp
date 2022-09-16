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
    @Published var currentModuleIndex = 0
    
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
}
