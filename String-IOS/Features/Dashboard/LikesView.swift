//
//  LikesView.swift
//  String-IOS
//
//  Created by BSTAR on 02/01/2026.
//

import SwiftUI

struct LikesView: View {
    
    @State private var searchText: String = ""
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @Namespace private var namespace
    @State private var users: [CardData] = [
        CardData(color: .purple, title: "Card 1", image: .man1),
        CardData(color: .blue, title: "Card 2", image: .man2),
        CardData(color: .green, title: "Card 3", image: .woman1),
        CardData(color: .orange, title: "Card 4", image: .woman2),
    ]
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
            
            BlurredCircleBg()
            
            ScrollView {
                VStack(alignment: .leading) {
                    
                    InputField(
                        text: $searchText,
                        placeholder: "Search for peoples and matches",
                        prefixIcon: Image(systemName: "magnifyingglass"),
                        radius: 15,
                        height: 38
                    )
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.5)
                    .animation(.easeInOut, value: animate)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    
                    HStack {
                        
                        Text("Matches")
                            .stingerRegularFont(size: 22)
                        
                        Text("62")
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .padding(.all, 5)
                            .background(.accent)
                            .clipShape(.circle)
                        
                    }
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.5)
                    .animation(.easeInOut.delay(0.2), value: animate)
                    .padding(.bottom, 10)
                    
                    LazyVGrid(columns: .init(repeating: .init(.flexible()), count: 2)) {
                        ForEach(0..<users.count) { index in
                            VStack(spacing: 0) {
                                
                                Image(users[index].image)
                                    .resizable()
                                    .frame(width: 165, height: 165)
                                    .clipShape(.circle)
                                    .matchedGeometryEffect(id: users[index].id, in: namespace)
                                    .onTapGesture(perform: {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                                            homeViewModel.selectedUser = users[index]
                                        }
                                    })
                                    .padding(.bottom, 10)
                                
                                Text("Elwa Rose")
                                    .stingerRegularFont(size: 22)
                                
                                Text("You’ve like eachother")
                                    .stingerRegularFont(size: 14)
                                
                            }
                            .opacity(animate ? 1 : 0)
                            .scaleEffect(animate ? 1 : 0.7)
                            .animation(.easeInOut.delay((Double(index) * 0.1) + 0.5), value: animate)
                            .padding(.bottom, 15)
                        }
                    }
                    
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
            }
            .animation(.easeInOut, value: animate)
            .scrollIndicators(.hidden)
            
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
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    LikesView()
        .environmentObject(HomeViewModel())
}
