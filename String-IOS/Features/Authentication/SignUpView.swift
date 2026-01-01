//
//  SignUpView.swift
//  String-IOS
//
//  Created by BSTAR on 31/12/2025.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        ZStack {
            BlurredCircleBg()
            
            AuthIntroViewCircles()
        }
        navigationBarBackButtonHidden()
    }
}

#Preview {
    SignUpView(
        path: .constant(NavigationPath())
    )
}
