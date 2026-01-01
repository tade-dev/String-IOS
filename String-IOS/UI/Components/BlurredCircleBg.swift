//
//  BlurredCircleBg.swift
//  String-IOS
//
//  Created by BSTAR on 31/12/2025.
//

import SwiftUI


struct BlurredCircleBg: View {
    var body: some View {
        
        ZStack {
            BlurredCircle()
                .offset(
                    x: UIScreen.main.bounds.width * -0.5,
                    y: UIScreen.main.bounds.height * -0.5
                )
            
            BlurredCircle()
                .offset(
                    x: UIScreen.main.bounds.width * -0.5,
                    y: UIScreen.main.bounds.height * 0.5
                )
            
            BlurredCircle(radius: 120)
                .offset(
                    x: UIScreen.main.bounds.width * 0.5,
                    y: UIScreen.main.bounds.height * 0
                )
        }
        
    }
}

struct BlurredCircle: View {
    
    var radius: CGFloat = 90
    
    var body: some View {
        PositionedCircleShape(size: 247)
            .blur(radius: radius)
            .opacity(0.7)
    }
}

#Preview {
    BlurredCircleBg()
}
