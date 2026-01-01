//
//  StringLogo.swift
//  String-IOS
//
//  Created by BSTAR on 30/12/2025.
//

import SwiftUI

struct StringLogo: View {
    
    var color: Color = .accentColor
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 4) {
            
            Text("String")
                .stingerRegularFont(size: 40)
                .foregroundStyle(color)
            
            PositionedCircleShape(
                size: 12,
                color: color
            )
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        
        StringLogo()
    }
}
