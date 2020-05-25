//
//  PianoView.swift
//  PianoPod
//
//  Created by Theodore Rothrock on 4/20/20.
//

import SwiftUI

struct PianoView: View {
    
    var naturalKeyColor: Color
    var accidentalKeyColor: Color
    var backgroundColor: Color
    var accentColor: Color
    
    @State private var isPresentingSettings = false
    @State private var bottomOctave: Int = 0
    @State private var visibleOctaves: Int = 1
    
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
                    .frame(width: 35, height: 35)
                    .foregroundColor(self.accentColor)
                    .padding([.top, .bottom, .trailing], 10)
                }
                
                Spacer()
                
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
                    }
                }

                Spacer()
            }
        }
        .sheet(isPresented: $isPresentingSettings, content: { SettingsView(isPresented: self.$isPresentingSettings, bottomOctave: self.$bottomOctave, visibleOctaves: self.$visibleOctaves) })
        .background(backgroundColor)
    }
    
    private func naturalKeyWidth(for size: CGSize) -> CGFloat {
        return size.width / (7 * CGFloat(visibleOctaves))
    }
    
    private func accidentalInterKeySpacing(for size: CGSize) -> CGFloat {
        return naturalKeyWidth(for: size) * 0.4
    }
    
    private func accidentalEndSpacing(for size: CGSize) -> CGFloat {
        return naturalKeyWidth(for: size) * 0.3
    }
    
}

struct PianoKeyView: View {
    
    var note: Note
    var color: Color
    var naturalKeyWidth: CGFloat
        
    private var naturalKeySize: CGSize {
        let naturalKeyAspectRatio: CGFloat = 2.2/15.0
        return CGSize(width: naturalKeyWidth, height: naturalKeyWidth / naturalKeyAspectRatio)
    }
    
    private var accidentalKeySize: CGSize {
        let accidentalKeyAspectRatio: CGFloat = 0.14
        let width = naturalKeyWidth * 0.6
        return CGSize(width: width, height: width / accidentalKeyAspectRatio)
    }
    
    private var radius: CGFloat {
        let divisor: CGFloat = isAccidental ? 9.0 : 7.0
        return naturalKeyWidth / divisor
    }
    
    private var isAccidental: Bool {
        let accidentals: [Pitch] = [.cSharp, .dSharp, .fSharp, .gSharp, .aSharp]
        return accidentals.contains(note.pitch)
    }
    
    private struct PianoKeyButtonStyle: ButtonStyle {
        var isAccidental: Bool
        
        private var verticalTranslation: CGFloat {
            return isAccidental ? 1.0 : 1.005
        }
        
        private var horizontalTranslation: CGFloat {
            return isAccidental ? 0.9 : 0.94
        }
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .scaleEffect(x: configuration.isPressed ? horizontalTranslation : 1.0, y: configuration.isPressed ? verticalTranslation : 1.0, anchor: .top)
        }
    }
    
    private struct PianoKeyShape: Shape {
        var isAccidental: Bool
        var radius: CGFloat
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }
    
    var body: some View {
        Button(action: {
            print("Play \(self.note.pitch.rawValue) \(self.note.octave)")
        }, label: {
            PianoKeyShape(isAccidental: isAccidental, radius: radius)
                .foregroundColor(self.color)
                .overlay(
                    PianoKeyShape(isAccidental: isAccidental, radius: radius)
                        .stroke(Color.black, lineWidth: 0.5)
                )
        })
        .frame(maxWidth: isAccidental ? accidentalKeySize.width : naturalKeySize.width, maxHeight: isAccidental ? accidentalKeySize.height : naturalKeySize.height)
        .buttonStyle(PianoKeyButtonStyle(isAccidental: isAccidental))
    }

}

struct PianoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//           PianoView(octave: 0, naturalKeyColor: .white, accidentalKeyColor: .black, backgroundColor: .gray)
//              .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//              .previewDisplayName("iPhone 8")

            PianoView(naturalKeyColor: .yellow, accidentalKeyColor: .pink, backgroundColor: .purple, accentColor: .white)
              .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
              .previewDisplayName("iPhone 11 Pro Max")
            
//            PianoView(octave: 0, naturalKeyColor: .white, accidentalKeyColor: .black, backgroundColor: .gray)
//                .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
//                .previewDisplayName("iPad Pro (9.7-inch)")
        }
    }
    
    
}
