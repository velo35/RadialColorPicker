//
//  CustomRadialButtonStyle.swift
//  RadialColorPicker
//
//  Created by Scott Daniel on 8/22/24.
//

import SwiftUI

struct CustomShrinkButtonStyle: ButtonStyle
{
    @State var cool = false
    private let scale = 0.95
    
    func makeBody(configuration: Configuration) -> some View
    {
        configuration.label
            .scaleEffect(x: configuration.isPressed ? scale : 1.0, y: configuration.isPressed ? scale : 1.0)
            .animation(.linear(duration: 0.10), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == CustomShrinkButtonStyle
{
    static var customShrink: CustomShrinkButtonStyle { .init() }
}
