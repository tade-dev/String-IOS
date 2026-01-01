//
//  AppBackButton.swift
//  String-IOS
//
//  Created by BSTAR on 31/12/2025.
//

import SwiftUI

struct AppBackButton: View {
    
    let onTap: () -> Void
    
    var body: some View {
        Image(.backButton)
            .onTapGesture {
                onTap()
            }
    }
}

#Preview {
    AppBackButton(
        onTap: {}
    )
}
