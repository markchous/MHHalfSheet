//
//  HalfSheet.swift
//  
//
//  Created by Mark Houston on 4/19/22.
//

import SwiftUI

/**
    **HalfSheet** is a `ViewModifier` that allows you to create a half sheet modal view at your convenience.
        
    It is simple in the face that it takes in three parameters, a `Bool` to show/hide the half sheet, a style, and a view to embed in the half sheet modal. This has been utilized to show information pop ups in a stylish manner that provides a better user experience.
 */
public struct HalfSheet<Sheet>: ViewModifier where Sheet: View {
    
    /**
     `dragOffset` provides information of how far the user has dragged the view in order to be able to check if it should be dismissed.
     */
    @State var dragOffset: CGFloat = 0
    
    /**
     `isPresented` is a `Published` property to check if the half sheet modal should be presented or not. A binding to a `Bool` should be passed into the `ViewModifier` init so that it can be dismissed properly when a drag to dismiss is detected or the user taps the close button.
     */
    @Binding var isPresented: Bool
    
    /**
    `style` is passed into the `ViewModifier`. To create a custom style, create a `struct` that inherits `HalfSheetStyle` protocol. If no style is passed in, the `DefaultStyle` will be used.
     */
    var style: HalfSheetStyle
    
    /**
     `sheet` is passed is a `View`. `Sheet` is used as a generic to take in a closure that creates a `View` to show as the half sheet modal.
     */
    var sheet: () -> Sheet
    
    /**
     `dragGesture` is an optional dismiss method. It detects if a user drags the half modal sheet down to dismiss. The default distance is set to 150. To customize the drag distance or to disable the gesture, set it in a custom style by inheriting `HalfSheetStyle` protocol and using the properties, `dragOffset`, and `disableDragDismiss`. It only allows the user to swipe down.
     */
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
    
    /**
     `dismiss` will change `isPresented` to false dismissing the half modal sheet. As well as reset the `dragOffset` to 0 for proper cleanup.
     */
    func dismiss() {
        withAnimation {
            isPresented = false
            dragOffset = 0
        }
    }
    
    /**
     `body` returns the modified view. The close button uses `Image(systemName: String)` to set the image. 
     */
    public func body(content: Content) -> some View {
        ZStack {
            content
               
            if isPresented {
                style.overlayColor
                    .opacity(style.opacity)
                    .ignoresSafeArea()

                VStack(alignment: .center) {
                    BarView()
                        .padding(.top, 16)
                    
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
                .simultaneousGesture(dragGesture)
                .ignoresSafeArea()
            }
        }
    }
}

extension View {
    /**
     `halfSheet` is a convenience method to pass configuration params to the modifer.
     
     - Parameters:
            - isPresented: A boolean flag that is bounded to the view. This determines if the half sheet modal is presented or not.
            - style: A `HalfSheetStyle` object that determines the styling of the half sheet modal. This is an optional param as it will defaul to `DefaultStyle` provided by the framework.
            - sheet: A `ViewBuilder` responsible for returning the `View` to show within the half sheet modal.
     
     - Returns: A modified `View` with or without the half sheet modal present.
     */
    public func halfSheet<Sheet: View>(isPresented: Binding<Bool>,
                                       style: HalfSheetStyle? = nil,
                                       @ViewBuilder sheet: @escaping () -> Sheet) -> some View {
        modifier(HalfSheet(isPresented: isPresented, style: style ?? DefaultStyle(), sheet: sheet))
    }
}
