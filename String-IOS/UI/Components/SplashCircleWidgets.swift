//
//  SplashCircleWidgets.swift
//  String-IOS
//
//  Created by BSTAR on 30/12/2025.
//

import SwiftUI

struct SplashCircleWidgets: View {
    var body: some View {
        
        
        DashedCircleShape(size: UIScreen.main.bounds.height * 0.59)
        
        DashedCircleShape(size: UIScreen.main.bounds.height * 0.59)
            .offset(
                x: UIScreen.main.bounds.width * 0.75,
                y: UIScreen.main.bounds.height * -0.35
            )
        
        DashedCircleShape(size: UIScreen.main.bounds.height * 0.59)
            .offset(
                x: UIScreen.main.bounds.width * -0.75,
                y: UIScreen.main.bounds.height * 0.35
            )
        
        PositionedCircleShape(size: 12)
            .offset(
                x: UIScreen.main.bounds.width * 0.12,
                y: UIScreen.main.bounds.height * -0.29
            )
        
        PositionedCircleShape(size: 12)
            .offset(
                x: UIScreen.main.bounds.width * -0.12,
                y: UIScreen.main.bounds.height * 0.29
            )
        
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        
        SplashCircleWidgets()
    }
}
