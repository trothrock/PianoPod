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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Stepper(value: $bottomOctave, in: -3...3, label: {
                    Text("Bottom octave: ")
                        .bold()
                    Text("\(bottomOctave)")
                })
                Divider()
                Stepper(value: $visibleOctaves, in: 1...3, label: {
                    Text("Visible octaves: ")
                        .bold()
                    Text("\(visibleOctaves)")
                })
                Divider()
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true), bottomOctave: .constant(0), visibleOctaves: .constant(1))
    }
}
