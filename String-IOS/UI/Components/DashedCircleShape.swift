//
//  DashedCircleShape.swift
//  String-IOS
//
//  Created by BSTAR on 30/12/2025.
//

import SwiftUI

struct DashedCircleShape: View {
    
    var size: CGFloat = UIScreen.main.bounds.height * 0.5
    var color: Color = .accentColor
    
    var body: some View {
        Circle()
            .stroke(style: .init(
                lineWidth: 0.2,
                dash: [5, 5]
            ))
            .fill(color)
            .frame(width: size, height: size)
    }
}

#Preview {
    ZStack {
        
        Color.black
            .ignoresSafeArea()
        
        DashedCircleShape()
        
    }
}
