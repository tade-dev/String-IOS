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

struct SwipeButtonStyle: ButtonStyle {
    
    let size: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: size, height: size)
            .padding(.all, 20)
            .overlay {
                Circle()
                    .stroke(.white)
            }
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
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

struct SwipeButtonModifier: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content.buttonStyle(SwipeButtonStyle(size: size))
    }
}
