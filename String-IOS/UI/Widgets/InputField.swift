//
//  InputField.swift
//  String-IOS
//
//  Created by BSTAR on 01/01/2026.
//

import SwiftUI

struct InputField: View {
    
    @Binding var text: String
    var placeholder: String = "Active Neno"
    var isPasswordField: Bool = false
    @FocusState private var isFocused: Bool
    var prefixIcon: Image?
    var suffixIcon: Image?
    var textStyle: String = AppConstants.regularFontName
    
    var body: some View {
            
        HStack(spacing: 15) {
            
            if let prefixIcon {
                prefixIcon
                    .renderingMode(.template)
                    .foregroundStyle(.black)
            }
            
            ZStack(alignment: .leading) {
                
                Group(content: {
                    if isPasswordField {
                        SecureField("", text: $text)
                    } else {
                        TextField("", text: $text)
                    }
                })
                .font(.custom(textStyle, size: 14))
                .foregroundStyle(.black)
                .focused($isFocused)
                
                if (!isFocused && text.isEmpty) {
                    Text(placeholder)
                        .stingerRegularFont(size: 14)
                        .foregroundStyle(.gray.opacity(0.8))
                }
                
            }
            
            if let suffixIcon {
                suffixIcon
                    .renderingMode(.template)
                    .foregroundStyle(.black)
                    .padding(.trailing, 20)
            }
                
        }
        .padding(.leading, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background {
            RoundedRectangle(cornerRadius: 45)
                .stroke(.black)
        }
        
    }
    
}

#Preview {
    InputField(
        text: .constant("")
    )
}
