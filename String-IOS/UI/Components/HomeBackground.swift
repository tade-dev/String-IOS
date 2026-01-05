//
//  HomeBackground.swift
//  String-IOS
//
//  Created by BSTAR on 02/01/2026.
//

import SwiftUI

struct HomeBackground: View {
    
    var showBlurredCircle: Bool = false
    
    var body: some View {
        ZStack {
            
            Color.darkBackground
                .ignoresSafeArea()
            
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
            
            if showBlurredCircle {
                BlurredCircle(
                    radius: 120
                )
                    .offset(
                        x: UIScreen.main.bounds.width * -0.5,
                        y: UIScreen.main.bounds.height * -0.5
                    )
            }
            
        }
    }
}

#Preview {
    HomeBackground()
}
