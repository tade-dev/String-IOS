//
//  ButtonStyle+Modifier.swift
//  String-IOS
//
//  Created by BSTAR on 31/12/2025.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    let buttonColor: Color
    let labelColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .stingerRegularFont(size: 20)
            .foregroundStyle(labelColor)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(buttonColor)
            .cornerRadius(50)
    }
}

struct PrimaryBorderedButtonStyle: ButtonStyle {
    
    let borderColor: Color
    let labelColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .stingerRegularFont(size: 20)
            .foregroundStyle(labelColor)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(borderColor)
            })
    }
}

struct PrimaryButtonModifier: ViewModifier {
    let buttonColor: Color
    let labelColor: Color
    func body(content: Content) -> some View {
        content.buttonStyle(PrimaryButtonStyle(buttonColor: buttonColor, labelColor: labelColor))
    }
}

struct PrimaryBorderedButtonModifier: ViewModifier {
    let borderColor: Color
    let labelColor: Color
    func body(content: Content) -> some View {
        content.buttonStyle(PrimaryBorderedButtonStyle(borderColor: borderColor, labelColor: labelColor))
    }
}

extension View {
    func primaryButtonStyle(buttonColor: Color = .accentColor, labelColor: Color = .white) -> some View {
        self.modifier(PrimaryButtonModifier(buttonColor: buttonColor, labelColor: labelColor))
    }
    func primaryBorderedButtonStyle(buttonColor: Color = .accentColor, labelColor: Color = .white) -> some View {
        self.modifier(PrimaryBorderedButtonModifier(borderColor: buttonColor, labelColor: labelColor))
    }
}
