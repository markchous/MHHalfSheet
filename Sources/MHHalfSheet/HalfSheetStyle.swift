//
//  HalfSheetStyle.swift
//  
//
//  Created by Mark Houston on 4/19/22.
//

import SwiftUI

public protocol HalfSheetStyle {
    var overlayColor: Color { get }
    var backgroundColor: Color { get }
    var closeImageColor: Color { get }
    var disableDragDismiss: Bool { get }
    var disableCardView: Bool { get }
    var closeImage: String { get }
    var cornerRadius: CGFloat { get }
    var dragOffset: CGFloat { get }
    var padding: CGFloat { get }
    var opacity: Double { get }
}

public extension HalfSheetStyle {
    var overlayColor: Color {
        .black
    }
    
    var backgroundColor: Color {
        .white
    }
    
    var closeImageColor: Color {
        .black
    }
    
    var closeImage: String {
        Constants.closeImage
    }
    
    var disableDragDismiss: Bool {
        false
    }
    
    var disableCardView: Bool {
        false
    }
    
    var cornerRadius: CGFloat {
        Constants.cornerRadius
    }
    
    var dragOffset: CGFloat {
        Constants.dragOffsetDismiss
    }
    
    var padding: CGFloat {
        Constants.padding
    }
    
    var opacity: Double {
        Constants.opacity
    }
}

struct DefaultStyle: HalfSheetStyle { }
