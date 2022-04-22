//
//  HalfSheetStyle.swift
//  
//
//  Created by Mark Houston on 4/19/22.
//

import SwiftUI

/**
 `HalfSheetStyle` allows you to customize the style of your half sheet modal. All properties are optional. If you don't want to change from the default values, do *not* set the property in your custom style.
 */
public protocol HalfSheetStyle {
    /**
     `overlayColor` will change the color of the background overlay.
     */
    var overlayColor: Color { get }
    
    /**
     `backgroundColor` will change the background of the half modal sheet.
     */
    var backgroundColor: Color { get }
    
    /**
     `closeImageColor` will change the foreground color of the close image button.
     */
    var closeImageColor: Color { get }
    
    /**
     `disableDragDismiss` will disable the drag to dismiss ability if set to true.
     */
    var disableDragDismiss: Bool { get }
    
    /**
     `disableCardView` will remove the `CardView` styling from the half sheet modal.
     */
    var disableCardView: Bool { get }
    
    /**
     `closeImage` will change the system image of the close button. This only accepts the name of system images.
     */
    var closeImageName: String { get }
    
    /**
     `cornerRadius` will change the `cornerRadius` of the `CardView` if it's enabled.
     */
    var cornerRadius: CGFloat { get }
    
    /**
     `dragOffset` will change the distance the user needs to drag the half sheet modal to dismiss it.
     */
    var dragOffset: CGFloat { get }
    
    /**
     `padding` will change the padding within the half sheet modal.
     */
    var padding: CGFloat { get }
    
    /**
     `opacity` will change the opacity value of the overlay.
     */
    var opacity: Double { get }
}

/**
 This is a default implementation of `HalfStyleSheet`. You can pick and choose which stlying options to customize.
 */
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
    
    var closeImageName: String {
        Constants.closeImageName
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
