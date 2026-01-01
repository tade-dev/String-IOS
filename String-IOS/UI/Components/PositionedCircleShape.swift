//
//  PositionedCircleShape.swift
//  String-IOS
//
//  Created by BSTAR on 30/12/2025.
//


import SwiftUI

struct PositionedCircleShape: View {
    
    var size: CGFloat = UIScreen.main.bounds.height * 0.1
    var color: Color = .accentColor
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
    }
}

#Preview {
    ZStack {
        
        Color.black
            .ignoresSafeArea()
        
        PositionedCircleShape()
        
    }
}
