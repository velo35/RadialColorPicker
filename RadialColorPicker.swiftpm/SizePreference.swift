//
//  SizePreference.swift
//  RadialColorPicker
//
//  Created by Scott Daniel on 9/6/24.
//

import SwiftUI

fileprivate struct SizePreferenceKey: PreferenceKey
{
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View
{
    func onSizeChange(_ callback: @escaping (CGSize) -> Void) -> some View
    {
        self.background {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: proxy.size)
                    .onPreferenceChange(SizePreferenceKey.self) { size in
                        callback(size)
                    }
            }
        }
    }
}
