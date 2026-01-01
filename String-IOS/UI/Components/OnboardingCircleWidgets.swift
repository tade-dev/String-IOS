//
//  OnboardingCircleWidgets.swift.swift
//  String-IOS
//
//  Created by BSTAR on 30/12/2025.
//

import SwiftUI

struct OnboardingCircleWidgets: View {
    
    var currentIndex: Int = 0
    @Namespace private var namespace
    
    var body: some View {
        
        DashedCircleShape(size: UIScreen.main.bounds.height * 0.59)
            .offset(
                x: UIScreen.main.bounds.width * 0.55,
                y: UIScreen.main.bounds.height * -0.45
            )
        
        DashedCircleShape(size: UIScreen.main.bounds.height * 0.59)
            .offset(
                x: UIScreen.main.bounds.width * -0.08,
                y: UIScreen.main.bounds.height * 0.25
            )
        
        Group {
            if currentIndex == 0 {
                PositionedCircleShape(size: 12)
                    .offset(
                        x: UIScreen.main.bounds.width * 0.36,
                        y: UIScreen.main.bounds.height * -0.37
                    )
                    .matchedGeometryEffect(id: "circle", in: namespace)
            }
            else if currentIndex == 1 {
                PositionedCircleShape(size: 12)
                    .offset(
                        x: UIScreen.main.bounds.width * 0.25,
                        y: UIScreen.main.bounds.height * 0.1
                    )
                    .matchedGeometryEffect(id: "circle", in: namespace)
            } else {
                PositionedCircleShape(size: 12)
                    .offset(
                        x: UIScreen.main.bounds.width * -0.35,
                        y: UIScreen.main.bounds.height * -0.4
                    )
                    .matchedGeometryEffect(id: "circle", in: namespace)
            }
        }
        .animation(.easeInOut, value: currentIndex)
        
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        
        OnboardingCircleWidgets()
    }
}
