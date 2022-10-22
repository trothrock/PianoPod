//
//  ColorPickerView.swift
//  PianoPod
//
//  Created by Theodore Rothrock on 5/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

struct ColorPickerView: View {
    
    @Binding var isPresented: Bool
    @Binding var selectedColor: Color
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.buttonPadding) {
                Spacer()
                    .frame(maxHeight: .infinity)
                HStack {
                    ForEach([Color.red, Color.orange, Color.yellow], id: \.self) { color in
                        ColorSelectionButton(fillColor: color, selectedColor: $selectedColor, presentationFlag: $isPresented)
                    }
                }
                HStack {
                    ForEach([Color.green, Color.blue, Color.purple], id: \.self) { color in
                        ColorSelectionButton(fillColor: color, selectedColor: $selectedColor, presentationFlag: $isPresented)
                    }
                }
                HStack {
                    ForEach([Color.pink, Color.white, Color.black], id: \.self) { color in
                        ColorSelectionButton(fillColor: color, selectedColor: $selectedColor, presentationFlag: $isPresented)
                    }
                }
                Spacer()
                    .frame(maxHeight: .infinity)
                
            }
            .padding([.leading, .trailing], Constants.buttonPadding)
            .navigationBarItems(trailing:
                Button(action: {
                    isPresented = false
                }, label: { Text(Constants.closeButtonTitle) })
            )
            .navigationBarTitle(Constants.viewTitle)
        }
        
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let closeButtonTitle = "Close"
        static let viewTitle = "Choose a color"
        static let buttonPadding: CGFloat = 20
    }
}

struct ColorSelectionButton: View {
    
    var fillColor: Color
    @Binding var selectedColor: Color
    @Binding var presentationFlag: Bool
    
    var body: some View {
        Button(action: {
            selectedColor = fillColor
            presentationFlag = false
        }, label: {
            BorderedCircleView(fillColor: fillColor)
        })
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(isPresented: .constant(true),
                        selectedColor: .constant(.red))
    }
}
