//
//  View+Ext.swift
//  
//
//  Created by Mark Houston on 4/19/22.
//

import SwiftUI

extension View {
    
    /// Conditionally apply a modifier to a View.
    ///  - Parameters:
    ///    - condition: The flag/condition to determine if the modifier is applied.
    ///    - transform: The modifier to apply to the View.
    ///  - Returns: If condition is true, returns the original View. If condition is false, returns the modified View.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
}
