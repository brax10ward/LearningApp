//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Braxton Ward on 9/16/22.
//

import SwiftUI

struct RectangleCard: View {
    var color = Color.white
    var height = 48.0
    
    var body: some View {
        Rectangle()
            .frame(height: height)
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard(color: .green)
    }
}
