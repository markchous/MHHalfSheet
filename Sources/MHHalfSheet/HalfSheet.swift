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
                let offset = value.translation.height
                if offset > 0 {
                    dragOffset = value.translation.height
                }
            }
            .onEnded { value in
                if dragOffset >= style.dragOffset {
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
                    .opacity(style.opacity)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    if let closeImage = style.closeImage {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: closeImage)
                                .foregroundColor(style.closeImageColor)
                        }
                        .padding(.horizontal, style.padding)
                        .padding(.top, style.padding)
                    }
                    
                    sheet()
                        .padding(.bottom, style.padding)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .bottom)
                }
                .zIndex(1)
                .background(style.backgroundColor)
                .if(!style.disableCardView, transform: { view in
                    view
                        .cardView(cornerRadius: style.cornerRadius)
                })
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
    public func halfSheet<Sheet: View>(isPresented: Binding<Bool>,
                                       style: HalfSheetStyle? = nil,
                                       @ViewBuilder sheet: @escaping () -> Sheet) -> some View {
        modifier(HalfSheet(isPresented: isPresented, style: style ?? DefaultStyle(), sheet: sheet))
    }
}
