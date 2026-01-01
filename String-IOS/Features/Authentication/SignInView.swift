//
//  SignInView.swift
//  String-IOS
//
//  Created by BSTAR on 31/12/2025.
//

import SwiftUI

struct SignInView: View {
    
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
    SignInView(
        path: .constant(NavigationPath())
    )
}
