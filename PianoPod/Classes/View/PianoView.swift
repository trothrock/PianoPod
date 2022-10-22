//
//  PianoView.swift
//  PianoPod
//
//  Created by Theodore Rothrock on 4/20/20.
//

import SwiftUI

struct PianoView: View {
    
    var backgroundColor: Color
    var accentColor: Color
    
    @State var naturalKeyColor: Color
    @State var accidentalKeyColor: Color
    @State var visibleOctaves: Int = 1
    @State var settingsEnabled: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                if settingsEnabled {
                    SettingsHeaderView(isPresentingSettings: $isPresentingSettings,
                                       toolbarControlHeight: Constants.toolbarControlHeight,
                                       toolbarPadding: Constants.toolbarPadding,
                                       accentColor: accentColor)
                }
                
                Spacer()
                    .frame(minHeight: 0)
                
                ZStack(alignment: .top) {
                    HStack(spacing: 0) {
                        ForEach(octaves, id: \.octaveIndex) { octave in
                                ForEach(octave.naturalNotes, id: \.id) { note in
                                    PianoKeyView(note: note,
                                                 color: naturalKeyColor,
                                                 naturalKeyWidth: naturalKeyWidth(for: geometry.size))
                                }
                        }
                    }
                    HStack(spacing: 0) {
                        ForEach(octaves, id: \.octaveIndex) { octave in
                            HStack(spacing: accidentalInterKeySpacing(for: geometry.size)) {
                                Rectangle()
                                .frame(width: accidentalEndSpacing(for: geometry.size), height: 0)
                                
                                ForEach(octave.lowerAccidentals, id: \.id) { note in
                                    PianoKeyView(note: note,
                                                 color: accidentalKeyColor,
                                                 naturalKeyWidth: naturalKeyWidth(for: geometry.size))
                                }
                                
                                Spacer()
                                
                                ForEach(octave.upperAccidentals, id: \.id) { note in
                                    PianoKeyView(note: note,
                                                 color: accidentalKeyColor,
                                                 naturalKeyWidth: naturalKeyWidth(for: geometry.size))
        
                                }
                                
                                Rectangle()
                                    .frame(width: accidentalEndSpacing(for: geometry.size), height: 0)
                            }
                        }
                    }.frame(width: (naturalKeyWidth(for: geometry.size) * 7) * CGFloat(visibleOctaves))
                }

                Spacer()
                    .frame(minHeight: 0)
            }
        }
        .sheet(isPresented: $isPresentingSettings,
               content: { SettingsView(isPresented: $isPresentingSettings,
                                       bottomOctave: $bottomOctave,
                                       visibleOctaves: $visibleOctaves,
                                       naturalKeyColor: $naturalKeyColor,
                                       accidentalKeyColor: $accidentalKeyColor)
        })
        .background(backgroundColor)
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let toolbarControlHeight: CGFloat = 35
        static let toolbarPadding: CGFloat = 7
    }
    
    @State private var isPresentingSettings = false
    @State private var bottomOctave: Int = 0
    
    private var toolbarHeight: CGFloat {
        return settingsEnabled ? Constants.toolbarControlHeight + (Constants.toolbarPadding * 2) : 0
    }
    
    private var octaves: [Octave] {
        var result = [Octave]()
        for octaveIndex in bottomOctave..<bottomOctave + visibleOctaves {
            result.append(Octave(octaveIndex: octaveIndex))
        }
        return result
    }
    
    private func naturalKeyWidth(for size: CGSize) -> CGFloat {
        let availableHeight = size.height - toolbarHeight
        let fullScreenWidth = size.width / (7 * CGFloat(visibleOctaves))
        let fullScreenHeight = fullScreenWidth / CGFloat.pianoKeyAspectRatio
        if fullScreenHeight > availableHeight {
            return availableHeight * CGFloat.pianoKeyAspectRatio
        }
        return fullScreenWidth
    }
    
    private func accidentalInterKeySpacing(for size: CGSize) -> CGFloat {
        return naturalKeyWidth(for: size) * 0.4
    }
    
    private func accidentalEndSpacing(for size: CGSize) -> CGFloat {
        return naturalKeyWidth(for: size) * 0.3
    }
    
    private func keyboardSize(for size: CGSize) -> CGSize {
        let keyWidth = naturalKeyWidth(for: size)
        return CGSize(width: (keyWidth * 7) * CGFloat(visibleOctaves), height: 0)
    }
    
}

struct SettingsHeaderView: View {
    
    @Binding var isPresentingSettings: Bool
    var toolbarControlHeight: CGFloat
    var toolbarPadding: CGFloat
    var accentColor: Color
    
    var body: some View {
        HStack() {
            Spacer()
            Button(action: {
                isPresentingSettings = true
            }, label: {
                Image(systemName: "gear")
                    .resizable()
            })
            .frame(width: toolbarControlHeight, height: toolbarControlHeight)
            .foregroundColor(accentColor)
            .padding(toolbarPadding)
        }
        .frame(height: toolbarControlHeight + (toolbarPadding * 2))
    }
    
}

struct PianoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PianoView(backgroundColor: .purple,
                      accentColor: .white,
                      naturalKeyColor: .yellow,
                      accidentalKeyColor: .pink)
              .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
              .previewDisplayName("iPhone 14 Pro")
        }
    }
    
    
}
