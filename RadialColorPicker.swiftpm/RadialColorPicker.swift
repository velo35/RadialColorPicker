//
//  RadialColorPicker.swift
//  RadialColorPicker
//
//  Created by Scott Daniel on 8/22/24.
//

import SwiftUI

struct RadialColorPicker: View
{
    @Binding var color: Color
    
    private let colors: [Color] = [.red, .orange, .yellow, .mint, .green, .cyan, .blue, .indigo, .pink]
    @State private var isActive = false
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
                        color = self.colors[ndx]
                    } label: {
                        Capsule()
                            .fill(colors[ndx])
                            .stroke(.black)
                            .frame(width: capsuleWidth, height: 0.5 * size)
                    }
                    .buttonStyle(.customShrink)
                    .rotationEffect(angle, anchor: .center)
                    .offset(x: isActive ? 0.25 * size * sin(angle.radians) : 0, y: isActive ? -0.25 * size * cos(angle.radians) : 0)
                    .animation(.default, value: isActive)
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
                .buttonStyle(.customShrink)
                .onSizeChange { size in
                    self.diameter = size.width
                }
                .padding(0.25 * size)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
