//
//  Font+Modifier.swift
//  String-IOS
//
//  Created by BSTAR on 30/12/2025.
//

import SwiftUI

struct FontModifier: ViewModifier {
    
    let fontName: String
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: size))
    }
}

extension View {
    
    func stingerRegularFont(size: CGFloat) -> some View {
        modifier(FontModifier(fontName: AppConstants.regularFontName, size: size))
    }
    
    func stingerBoldFont(size: CGFloat) -> some View {
        modifier(FontModifier(fontName: AppConstants.boldFontName, size: size))
    }
    
}
