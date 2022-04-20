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
    var disableCardView: Bool { get }
    var cornerRadius: CGFloat { get }
}

public struct DefaultStyle: HalfSheetStyle {
    public var overlayColor: Color {
        .black
    }
    
    public var backgroundColor: Color {
        .white
    }
    
    public var closeImage: String {
        "x.circle.full"
    }
    
    public var closeImageColor: Color {
        .black
    }
    
    public var disableDragDismiss: Bool {
        false
    }
    
    public var disableCardView: Bool {
        false
    }
    
    public var cornerRadius: CGFloat {
        20.0
    }
    
    public init() { }
}
