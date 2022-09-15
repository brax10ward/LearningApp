//
//  LearningApp.swift
//  LearningApp
//
//  Created by Braxton Ward on 9/15/22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
