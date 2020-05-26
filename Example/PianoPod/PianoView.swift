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
    @State private var isPresentingSettings = false
    @State private var bottomOctave: Int = 0
    @State private var visibleOctaves: Int = 1
    
    private let toolbarControlHeight: CGFloat  = 35
    private let toolbarPadding: CGFloat  = 7
    
    private var toolbarHeight: CGFloat {
        return toolbarControlHeight + (toolbarPadding * 2)
    }
    
    private var octaves: [Octave] {
        var result = [Octave]()
        for octaveIndex in bottomOctave..<bottomOctave + visibleOctaves {
            result.append(Octave(octaveIndex: octaveIndex))
        }
        return result
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack() {
                    Spacer()
                    Button(action: {
                        self.isPresentingSettings = true
                    }, label: {
                        Image(systemName: "gear")
                            .resizable()
                    })
                    .frame(width: self.toolbarControlHeight, height: self.toolbarControlHeight)
                    .foregroundColor(self.accentColor)
                    .padding(self.toolbarPadding)
                }
                .frame(height: self.toolbarHeight)
                
                Spacer()
                    .frame(minHeight: 0)
                
                ZStack(alignment: .top) {
                    HStack(spacing: 0) {
                        ForEach(self.octaves, id: \.octaveIndex) { octave in
                                ForEach(octave.naturalNotes, id: \.id) { note in
                                    PianoKeyView(note: note, color: self.naturalKeyColor, naturalKeyWidth: self.naturalKeyWidth(for: geometry.size))
                                }
                        }
                    }
                    HStack(spacing: 0) {
                        ForEach(self.octaves, id: \.octaveIndex) { octave in
                            HStack(spacing: self.accidentalInterKeySpacing(for: geometry.size)) {
                                Rectangle()
                                .frame(width: self.accidentalEndSpacing(for: geometry.size), height: 0)
                                
                                ForEach(octave.lowerAccidentals, id: \.id) { note in
                                    PianoKeyView(note: note, color: self.accidentalKeyColor, naturalKeyWidth: self.naturalKeyWidth(for: geometry.size))
                                }
                                
                                Spacer()
                                
                                ForEach(octave.upperAccidentals, id: \.id) { note in
                                    PianoKeyView(note: note, color: self.accidentalKeyColor, naturalKeyWidth: self.naturalKeyWidth(for: geometry.size))
        
                                }
                                
                                Rectangle()
                                    .frame(width: self.accidentalEndSpacing(for: geometry.size), height: 0)
                            }
                        }
                    }.frame(width: (self.naturalKeyWidth(for: geometry.size) * 7) * CGFloat(self.visibleOctaves))
                }

                Spacer()
                    .frame(minHeight: 0)
            }
        }
        .sheet(isPresented: $isPresentingSettings, content: { SettingsView(isPresented: self.$isPresentingSettings, bottomOctave: self.$bottomOctave, visibleOctaves: self.$visibleOctaves, naturalKeyColor: self.$naturalKeyColor, accidentalKeyColor: self.$accidentalKeyColor) })
        .background(backgroundColor)
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
    
}

struct PianoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PianoView(backgroundColor: .purple, accentColor: .white, naturalKeyColor: .yellow, accidentalKeyColor: .pink)
              .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
              .previewDisplayName("iPhone 11 Pro Max")
        }
    }
    
    
}
