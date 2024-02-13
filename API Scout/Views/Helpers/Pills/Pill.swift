//
//  Pill.swift
//  API Scout
//
//  Created by Lucas on 2/12/24.
//

import SwiftUI

/// Standard data presentation pill, should be used for displaying small snippets of info together
struct Pill: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var text: String
    var textColor: (ColorScheme) -> Color
    var backgroundColor: (ColorScheme) -> Color

    init(_ text: String, textColor: @escaping (ColorScheme) -> Color = defaultTextColor, backgroundColor: @escaping (ColorScheme) -> Color = defaultBackgroundColor) {
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Text(text)
            .foregroundStyle(textColor(colorScheme))
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                    .fill(backgroundColor(colorScheme))
                    .padding(-9)
            )
    }
    
    private static func defaultTextColor(colorScheme: ColorScheme) -> Color {
        return if colorScheme == .light {
            .white
        }
        else {
            .black
        }
    }

    private static func defaultBackgroundColor(colorScheme: ColorScheme) -> Color {
        return if colorScheme == .light {
            .black
        }
        else {
            .white
        }
    }
}

#Preview {
    Group {
        Pill("Default").padding()
        Pill("Static White on Black", textColor: { _ in
            .white
        }, backgroundColor:  { _ in
            .black
        }).padding()
        Pill("Static Black on White", textColor: { _ in
            .black
        }, backgroundColor: { _ in
            .white
        }).padding()
    }
}
