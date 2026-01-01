//
//  OnboardingPageIndicator.swift
//  String-IOS
//
//  Created by BSTAR on 31/12/2025.
//

import SwiftUI

struct OnboardingPageIndicator: View {
    
    var currentPage: Int = 0
    var totalPages: Int = 3
    
    var body: some View {
        HStack {
            ForEach(0..<totalPages) { index in
                RoundedRectangle(cornerRadius: 5)
                    .fill(currentPage == index ? .accent : .white)
                    .frame(width: currentPage == index ? 40 : 10, height: 10)
                    .animation(.easeInOut, value: currentPage)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        
        OnboardingPageIndicator()
    }
}
