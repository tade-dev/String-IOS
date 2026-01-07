//
//  RootView.swift
//  String-IOS
//
//  Created by BSTAR on 30/12/2025.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject private var rootViewModel: RootViewModel
    
    var body: some View {
        
        Group {
            
            switch rootViewModel.appState {
            case .splash:
                SplashScreen()
                    .onAppear {
                        determineNextView()
                    }
            case .onboarding:
                OnboardingView()
            case .authentication:
                AuthenticationView()
            case .main:
                MainView()
            }
            
        }
        .animation(.easeInOut, value: rootViewModel.appState)
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        
    }
    
    func determineNextView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            rootViewModel.appState = .onboarding
        }
    }
    
}

#Preview {
    RootView()
        .environmentObject(RootViewModel())
}
