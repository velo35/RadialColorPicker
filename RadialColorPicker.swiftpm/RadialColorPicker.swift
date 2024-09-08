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
            
            Button {
                var transaction = Transaction(animation: .easeInOut(duration: 0.25))
                if isActive {
                    transaction.disablesAnimations = true
                }
                withTransaction(transaction) {
                    isActive.toggle()
                }
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
            .background {
                ForEach(0 ..< 9) { ndx in
                    let angle = Angle.radians(Double(ndx) * 2 * Double.pi / 9.0)
                    
                    Button {
                        color = self.colors[ndx]
                    } label: {
                        Capsule()
                            .fill(colors[ndx])
                            .strokeBorder(.black, lineWidth: 4)
                            .frame(width: capsuleWidth, height: 0.5 * size)
                    }
                    .buttonStyle(.customShrink)
                    .offset(y: isActive ? 0 : 0.25 * size)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .clipped()
                    .rotationEffect(angle, anchor: .bottom)
                    .animation(.spring(duration: 0.5, bounce: 0.7).delay(0.1 * Double(ndx)), value: isActive)
                }
                .alignmentGuide(VerticalAlignment.center) { d in
                    d[.bottom]
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
