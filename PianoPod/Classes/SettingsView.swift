//
//  SettingsView.swift
//  PianoPod_Example
//
//  Created by Theodore Rothrock on 5/25/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isPresented: Bool
    @Binding var bottomOctave: Int
    @Binding var visibleOctaves: Int
    @Binding var naturalKeyColor: Color
    @Binding var accidentalKeyColor: Color
    
    @State private var isPresentingNaturalKeyColorPicker: Bool = false
    @State private var isPresentingAccidentalKeyColorPicker: Bool = false
    
    private let menuItemHeight: CGFloat = 50
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Group {
                    Stepper(value: $visibleOctaves, in: 1...3, label: {
                        Text("Visible octaves: ")
                            .bold()
                        Text("\(visibleOctaves)")
                    })
                    .frame(height: menuItemHeight)
                    
                    Divider()
                    
                    Stepper(value: $bottomOctave, in: -3...3, label: {
                        Text("Bottom note: ")
                            .bold()
                        Text("C\(bottomOctave)")
                    })
                    .frame(height: menuItemHeight)
                    
                    Divider()
                }
                
                Group {
                    HStack {
                        Text("Natural key color:")
                            .bold()
                        Spacer()
                        ColorSelectionPresentationButton(fillColor: naturalKeyColor, presentationFlag: $isPresentingNaturalKeyColorPicker)
                        .frame(width: 40, height: 40)
                    }
                    .frame(height: menuItemHeight)
                    .sheet(isPresented: $isPresentingNaturalKeyColorPicker, content: { ColorPickerView(isPresented: self.$isPresentingNaturalKeyColorPicker, selectedColor: self.$naturalKeyColor) })
                    
                    Divider()
                    
                    HStack {
                        Text("Accidental key color:")
                            .bold()
                        Spacer()
                        ColorSelectionPresentationButton(fillColor: accidentalKeyColor, presentationFlag: $isPresentingAccidentalKeyColorPicker)
                        .frame(width: 40, height: 40)
                        .sheet(isPresented: $isPresentingAccidentalKeyColorPicker, content: { ColorPickerView(isPresented: self.$isPresentingAccidentalKeyColorPicker, selectedColor: self.$accidentalKeyColor) })
                    }
                    .frame(height: menuItemHeight)
                    
                    Divider()
                }
                
                Spacer()
            }
            .navigationBarItems(trailing:
                Button(action: {
                    self.isPresented = false
                }, label: { Text("Close") })
            )
            .navigationBarTitle("Settings")
            .padding(20)
        }
    }
}

struct ColorSelectionPresentationButton: View {
    
    var fillColor: Color
    @Binding var presentationFlag: Bool
    
    var body: some View {
        Button(action: {
            self.presentationFlag.toggle()
        }, label: {
            BorderedCircleView(fillColor: fillColor)
        })
    }
    
}

struct BorderedCircleView: View {
    var fillColor: Color
    
    var body: some View {
        Circle()
        .fill(fillColor)
        .overlay(
            Circle()
                .strokeBorder(Color.black, lineWidth: 1)
        )
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true), bottomOctave: .constant(0), visibleOctaves: .constant(1), naturalKeyColor: .constant(.yellow), accidentalKeyColor: .constant(.red))
    }
}
