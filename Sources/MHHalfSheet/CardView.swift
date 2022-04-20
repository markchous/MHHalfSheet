//
//  CardView.swift
//  
//
//  Created by Mark Houston on 4/20/22.
//

import SwiftUI

struct CardView: ViewModifier {
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(cornerRadius)
            .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 0)
    }
}

extension View {
    func cardView(cornerRadius: CGFloat) -> some View {
        modifier(CardView(cornerRadius: cornerRadius))
    }
}
