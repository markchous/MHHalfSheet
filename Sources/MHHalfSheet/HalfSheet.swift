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
    
    var dragOffsetDismiss: CGFloat {
        style.dragOffset ?? Constants.dragOffsetDismiss
    }
    var paddingValue: CGFloat {
        style.padding ?? Constants.padding
    }
    var cornerRadius: CGFloat {
        style.cornerRadius ?? Constants.cornerRadius
    }
    var opacity: Double {
        style.opacity ?? Constants.opacity
    }
    var dragGesture: some Gesture {
        return DragGesture()
            .onChanged { value in
                let offset = value.translation.height
                if offset > 0 {
                    dragOffset = value.translation.height
                }
            }
            .onEnded { value in
                if dragOffset >= dragOffsetDismiss {
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
                    .opacity(opacity)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    if let closeImage = style.closeImage {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: closeImage)
                                .foregroundColor(style.closeImageColor)
                        }
                        .padding(.horizontal, paddingValue)
                        .padding(.top, paddingValue)
                    }
                    
                    sheet()
                        .padding(.bottom, paddingValue)
                }
                .background(style.backgroundColor)
                .if(!style.disableCardView, transform: { view in
                    view
                        .cardView(cornerRadius: cornerRadius)
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
