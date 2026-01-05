//
//  ProfileView.swift
//  String-IOS
//
//  Created by BSTAR on 02/01/2026.
//

import SwiftUI

enum ProfileRoute: Hashable {
    case appSetting
    case myPreference
}

struct ProfileView: View {
    
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                
                BlurredCircleBg()
                
                ScrollView {
                    VStack(spacing: 0) {
                        
                        Image(.man1)
                            .resizable()
                            .frame(width: 158, height: 158)
                            .clipShape(.circle)
                            .frame(width: 180, height: 180)
                            .overlay(alignment: .bottom) {
                                Image(.editProfile)
                                    .padding(.all, 8)
                                    .background(.accent)
                                    .clipShape(.circle)
                            }
                            .padding(.bottom, 10)
                            .padding(.top, 20)
                        
                        Text("Patrick Hale")
                            .stingerRegularFont(size: 22)
                        
                        Text("Sans Francisco US")
                            .stingerRegularFont(size: 15)
                            .foregroundStyle(.gray.opacity(0.8))
                            .padding(.bottom, 10)
                        
                        ProfileItems(image: .favourites, title: "My Preferences", description: "Lorem ipsum dolor sit amet")
                            .onTapGesture {
                                path.append(ProfileRoute.myPreference)
                            }
                        
                        ProfileItems(image: .favourites, title: "Favourites", description: "Lorem ipsum dolor sit amet")
                        
                        ProfileItems(image: .favourites, title: "String Premium", description: "Lorem ipsum dolor sit amet")
                        
                        ProfileItems(image: .settngs, title: "App Setting", description: "Lorem ipsum dolor sit amet")
                            .onTapGesture {
                                path.append(ProfileRoute.appSetting)
                            }
                        
                        ProfileItems(image: .needHelp, title: "Need Help?", description: "Lorem ipsum dolor sit amet", isLast: true)
                        
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 20)
                
            }
            .navigationDestination(for: ProfileRoute.self) { route in
                switch route {
                case .appSetting: AppSettingsView()
                case .myPreference: MyPreferencesView()
                }
            }
        }
    }
}

struct ProfileItems: View {
    
    let image: ImageResource
    let title: String
    let description: String
    var isLast: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .frame(maxWidth: 24)
                    .frame(height: 24)
                    .foregroundStyle(.black)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .stingerRegularFont(size: 18)
                        .foregroundStyle(.black)
                    
                    Text(description)
                        .stingerRegularFont(size: 15)
                        .foregroundStyle(.gray.opacity(0.8))
                }
                
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.black)
                
            }
            .padding(.vertical, 20)
            if !isLast {
                Color.black
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.7)
            }
        }
        .padding(.horizontal, 15)
    }
    
}

#Preview {
    ProfileView()
}
