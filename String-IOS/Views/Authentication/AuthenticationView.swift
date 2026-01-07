//
//  AuthenticationView.swift
//  String-IOS
//
//  Created by BSTAR on 30/12/2025.
//

import SwiftUI

enum AuthRoute: Hashable {
    case authIntroView
    case createAccountView
    case signInView
    case signUpView
    case username
    case gender
    case birthday
    case photos
    case verifyImageView(image: UIImage)
}

struct AuthenticationView: View {

    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            AuthIntroView(path: $path)
                .navigationDestination(for: AuthRoute.self) { route in
                    switch route {
                    case .authIntroView: AuthIntroView(path: $path)
                    case .createAccountView: CreateAccountView(path: $path)
                    case .signInView: SignInView(path: $path)
                    case .signUpView: SignUpView(path: $path)
                    case .username: UsernameView(path: $path)
                    case .gender: GenderView(path: $path)
                    case .birthday: BirthdayView(path: $path)
                    case .photos: PhotosView(path: $path)
                    case .verifyImageView(let image): VerifyImageView(path: $path, image: image)
                    }
                }
        }
    }
}

#Preview {
    AuthenticationView()
}
