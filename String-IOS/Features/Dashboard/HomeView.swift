//
//  HomeView.swift
//  String-IOS
//
//  Created by BSTAR on 02/01/2026.
//

import SwiftUI

enum HomeRoute: Hashable, Equatable {
    case home
    case premium
}

struct HomeView: View {
    
    @State private var path = NavigationPath()
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                HomeBackground(showBlurredCircle: true)
                
                VStack {
                    header
                    
                    Spacer()
                    
                    SwipeableCards(namespace: namespace)
                    
                    Spacer()
                    
                    HStack(spacing: 15) {
                        ActionButtons(image: Image(.close), size: 33, onTap: {})
                        ActionButtons(image: Image(.message2), size: 55, onTap: {})
                        ActionButtons(image: Image(.like), size: 33, onTap: {})
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: UIScreen.main.bounds.width)
                
                if let selectedUser = homeViewModel.selectedUser {
                    UserDetailsOverlay(
                        user: selectedUser,
                        namespace: namespace,
                        onDismiss: {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                                homeViewModel.selectedUser = nil
                            }
                        }
                    )
                }
            }
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                case .home: HomeView()
                case .premium: PremiumView()
                }
            }
        }
    }
    
    private var header: some View {
        HStack {
            HStack(spacing: 12) {
                Image(.man1)
                    .resizable()
                    .frame(width: 47, height: 47)
                    .clipShape(.circle)
                    .overlay { Circle().stroke(.white) }
                Text("Hi,👋 Andrew")
                    .stingerBoldFont(size: 18)
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Image(.like)
                .resizable()
                .frame(width: 32, height: 27.5)
                .frame(width: 38, height: 38)
                .onTapGesture {
                    path.append(HomeRoute.premium)
                }
                .overlay(alignment: .topTrailing) {
                    Text("12")
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .semibold))
                        .padding(.all, 3)
                        .background(.black)
                        .clipShape(.circle)
                }
        }
        .padding(.top, 10)
    }
}

struct ActionButtons: View {
    
    let image: Image
    let size: CGFloat
    let onTap: ()-> Void
    
    var body: some View {
        image
            .frame(width: size, height: size)
            .padding(.all, 20)
            .overlay {
                Circle()
                    .stroke(.white)
            }
            .onTapGesture {
                onTap()
            }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
