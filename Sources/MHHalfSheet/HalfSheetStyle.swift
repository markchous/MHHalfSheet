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
    var closeImage: String { get }
    var disableDragDismiss: Bool { get }
}

struct DefaultStyle: HalfSheetStyle {
    var overlayColor: Color {
        .black
    }
    
    var backgroundColor: Color {
        .white
    }
    
    var closeImage: String {
        "x.circle.full"
    }
    
    var closeImageColor: Color {
        .black
    }
    
    var disableDragDismiss: Bool {
        false
    }
}
