//
//  AuthIntroViewCircles.swift
//  String-IOS
//
//  Created by BSTAR on 31/12/2025.
//

import SwiftUI

struct AuthIntroViewCircles: View {
    var body: some View {
        
        ZStack {
            PositionedCircleShape(size: 12)
                .offset(
                    x: UIScreen.main.bounds.width * -0.35,
                    y: UIScreen.main.bounds.height * -0.38
                )
            
            PositionedCircleShape(size: 30)
                .offset(
                    x: UIScreen.main.bounds.width * 0.3,
                    y: UIScreen.main.bounds.height * -0.35
                )
            
            PositionedCircleShape(size: 12)
                .offset(
                    x: UIScreen.main.bounds.width * 0.22,
                    y: UIScreen.main.bounds.height * 0.1
                )
            
            PositionedCircleShape(size: 28)
                .offset(
                    x: UIScreen.main.bounds.width * -0.2,
                    y: UIScreen.main.bounds.height * -0.1
                )

        }
    }
}

#Preview {
    AuthIntroViewCircles()
}
