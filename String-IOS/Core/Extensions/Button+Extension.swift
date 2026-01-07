//
//  Button+Extension.swift
//  String-IOS
//
//  Created by BSTAR on 06/01/2026.
//

import SwiftUI

extension View {
    func primaryButtonStyle(buttonColor: Color = .accentColor, labelColor: Color = .white) -> some View {
        self.modifier(PrimaryButtonModifier(buttonColor: buttonColor, labelColor: labelColor))
    }
    
    func primaryBorderedButtonStyle(buttonColor: Color = .accentColor, labelColor: Color = .white) -> some View {
        self.modifier(PrimaryBorderedButtonModifier(borderColor: buttonColor, labelColor: labelColor))
    }
    
    func swipeButtonStyle(size: CGFloat) -> some View {
        self.modifier(SwipeButtonModifier(size: size))
    }
}
