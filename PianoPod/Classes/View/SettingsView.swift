//
//  SettingsView.swift
//  PianoPod
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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Group {
                    Stepper(value: $visibleOctaves, in: 1...3, label: {
                        Text(Constants.octaveHeading)
                            .bold()
                        Text("\(visibleOctaves)")
                    })
                    .frame(height: Constants.menuItemHeight)
                    
                    Divider()
                    
                    Stepper(value: $bottomOctave, in: -3...3, label: {
                        Text(Constants.bottomNoteHeading)
                            .bold()
                        Text("C\(bottomOctave)")
                    })
                    .frame(height: Constants.menuItemHeight)
                    
                    Divider()
                }
                
                Group {
                    HStack {
                        Text(Constants.naturalKeyHeading)
                            .bold()
                        Spacer()
                        ColorSelectionPresentationButton(fillColor: naturalKeyColor,
                                                         presentationFlag: $isPresentingNaturalKeyColorPicker)
                        .frame(width: 40, height: 40)
                    }
                    .frame(height: Constants.menuItemHeight)
                    .sheet(isPresented: $isPresentingNaturalKeyColorPicker, content: { ColorPickerView(isPresented: $isPresentingNaturalKeyColorPicker, selectedColor: $naturalKeyColor) })
                    
                    Divider()
                    
                    HStack {
                        Text(Constants.accidentalKeyHeading)
                            .bold()
                        Spacer()
                        ColorSelectionPresentationButton(fillColor: accidentalKeyColor,
                                                         presentationFlag: $isPresentingAccidentalKeyColorPicker)
                        .frame(width: 40, height: 40)
                        .sheet(isPresented: $isPresentingAccidentalKeyColorPicker,
                               content: { ColorPickerView(isPresented: $isPresentingAccidentalKeyColorPicker,
                                                          selectedColor: $accidentalKeyColor)
                        })
                    }
                    .frame(height: Constants.menuItemHeight)
                    
                    Divider()
                }
                
                Spacer()
            }
            .navigationBarItems(trailing:
                Button(action: {
                    isPresented = false
            }, label: { Text(Constants.closeButtonTitle) })
            )
            .navigationBarTitle(Constants.navigationTitle)
            .padding(20)
        }
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let navigationTitle = "Settings"
        static let closeButtonTitle = "Close"
        static let octaveHeading = "Visible octaves:"
        static let bottomNoteHeading = "Bottom note:"
        static let naturalKeyHeading = "Natural key color:"
        static let accidentalKeyHeading = "Accidental key color:"
        static let menuItemHeight: CGFloat = 50
    }
    
    @State private var isPresentingNaturalKeyColorPicker: Bool = false
    @State private var isPresentingAccidentalKeyColorPicker: Bool = false
    
}

struct ColorSelectionPresentationButton: View {
    
    var fillColor: Color
    @Binding var presentationFlag: Bool
    
    var body: some View {
        Button(action: {
            presentationFlag.toggle()
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
        SettingsView(isPresented: .constant(true),
                     bottomOctave: .constant(0),
                     visibleOctaves: .constant(1),
                     naturalKeyColor: .constant(.yellow),
                     accidentalKeyColor: .constant(.red))
    }
}
