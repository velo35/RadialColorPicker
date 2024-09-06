//
//  RadialColorPicker.swift
//  RadialColorPicker
//
//  Created by Scott Daniel on 8/22/24.
//

import SwiftUI

fileprivate struct DiameterPreferenceKey: PreferenceKey
{
    static let defaultValue = 0.0
    static func reduce(value: inout Double, nextValue: () -> Double) {}
}

struct RadialColorPicker: View
{
    @Binding var color: Color
    
    private let colors: [Color] = [.red, .orange, .yellow, .mint, .green, .cyan, .blue, .indigo, .pink]
    @State private var isActive = true
    @State private var diameter = 0.0
    
    private var capsuleWidth: Double
    {
        diameter * sin(Double.pi / 9.0)
    }
    
    var body: some View
    {
        GeometryReader { proxy in
            let size = min(proxy.size.width, proxy.size.height)
            
            ZStack {
                ForEach(0 ..< 9) { ndx in
                    let angle = Angle.radians(Double(ndx) * 2 * Double.pi / 9.0)
                    
                    Button {
                        
                    } label: {
                        Capsule()
                            .fill(colors[ndx])
                            .stroke(.black)
                            .frame(width: capsuleWidth, height: 0.5 * size)
                    }
                    .rotationEffect(angle, anchor: .bottom)
                    .alignmentGuide(VerticalAlignment.center) { d in
                        d[VerticalAlignment.bottom]
                    }
                    .offset(x: isActive ? 0 : -0.25 * size * sin(angle.radians), y: isActive ? 0 : 0.25 * size * cos(angle.radians))
                    .animation(.spring(duration: 0.75, bounce: 0.9), value: isActive)
                }
                
                Button {
                    isActive.toggle()
                } label: {
                    Circle()
                        .fill(color)
                        .overlay {
                            ZStack {
                                Circle()
                                    .stroke(lineWidth: 8)
                                    .blur(radius: 8)
                                    .padding(4)
                                    .clipShape(Circle())
                                
                                Circle()
                                    .stroke(.black, lineWidth: min(14, 0.125 * size))
                                
                                Circle()
                                    .stroke(.white, lineWidth: min(8, 0.05 * size))
                            }
                        }
                }
                .buttonStyle(.customRadial)
                .background {
                    GeometryReader { circleProxy in
                        Color.clear
                            .preference(key: DiameterPreferenceKey.self, value: circleProxy.size.width)
                            .onPreferenceChange(DiameterPreferenceKey.self) { value in
                                self.diameter = value
                            }
                    }
                }
                .padding(0.25 * size)
            }
        }
    }
}
