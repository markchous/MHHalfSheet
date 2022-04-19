//
//  HalfSheet.swift
//  
//
//  Created by Mark Houston on 4/19/22.
//

import SwiftUI

public struct HalfSheet<Sheet>: ViewModifier where Sheet: View {
    @Binding var isPresented: Bool
    var style: HalfSheetStyle
    var sheet: () -> Sheet
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                style.overlayColor
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Button {
                        withAnimation {
                            self.isPresented = false
                        }
                    } label: {
                        Image(systemName: style.closeImage)
                            .foregroundColor(style.closeImageColor)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    
                    sheet()
                        .padding(.bottom, 16)
                }
                .background(style.backgroundColor)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .bottom)
                .transition(.move(edge: .bottom))
                .ignoresSafeArea()
            }
        }
    }
}

extension View {
    func halfSheet<Sheet: View>(isPresented: Binding<Bool>, style: HalfSheetStyle = DefaultStyle(), @ViewBuilder sheet: @escaping () -> Sheet) -> some View {
        modifier(HalfSheet(isPresented: isPresented, style: style, sheet: sheet))
    }
}
