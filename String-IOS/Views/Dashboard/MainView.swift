//
//  MainView.swift
//  String-IOS
//
//  Created by BSTAR on 30/12/2025.
//

import SwiftUI

struct MainView: View {
    
    @State private var selection: Int = 0
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        
        ZStack {
            
            TabView(selection: $selection) {
                
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag(0)
                
                LikesView()
                    .tabItem {
                        Image(systemName: "heart")
                    }
                    .tag(1)
                
                MessageView()
                    .tabItem {
                        Image(systemName: "ellipsis.message")
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                    }
                    .tag(3)
                
            }
            
            if homeViewModel.showMatchedScreen {
                MatchedView()
            }
            
            
        }
        
    }
}

#Preview {
    MainView()
        .environmentObject(HomeViewModel())
}
