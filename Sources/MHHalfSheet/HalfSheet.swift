//
//  HalfSheet.swift
//  
//
//  Created by Mark Houston on 4/19/22.
//

import SwiftUI

public struct HalfSheet<Sheet>: ViewModifier where Sheet: View {
    @State var dragOffset: CGFloat = 0
    @Binding var isPresented: Bool
    var style: HalfSheetStyle
    var sheet: () -> Sheet
    
    var dragGesture: some Gesture {
        return DragGesture()
            .onChanged { value in
                print(value.translation.height)
                let offset = value.translation.height
                if offset > 0 {
                    dragOffset = value.translation.height
                }
            }
            .onEnded { value in
                if dragOffset >= 150 {
                    dismiss()
                } else {
                    dragOffset = 0
                }
            }
    }
    
    func dismiss() {
        withAnimation {
            isPresented = false
            dragOffset = 0
        }
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                style.overlayColor
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Button {
                        dismiss()
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
                .cardView(cornerRadius: style.cornerRadius)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .bottom)
                .transition(.move(edge: .bottom))
                .offset(y: dragOffset)
                .opacity(2 - Double(dragOffset / 50))
                .if(!style.disableDragDismiss, transform: { view in
                    view
                        .simultaneousGesture(dragGesture)
                })
                .ignoresSafeArea()
            }
        }
    }
}

extension View {
    func halfSheet<Sheet: View>(isPresented: Binding<Bool>,
                                style: HalfSheetStyle = DefaultStyle(),
                                @ViewBuilder sheet: @escaping () -> Sheet) -> some View {
        modifier(HalfSheet(isPresented: isPresented, style: style, sheet: sheet))
    }
}
