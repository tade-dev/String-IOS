//
//  PrimaryBtn.swift
//  String-IOS
//
//  Created by BSTAR on 31/12/2025.
//

import SwiftUI

struct PrimaryBtn: View {
    
    var onButtonPressed: ()-> Void
    var buttonColor: Color = .accentColor
    var buttonLabel: String = "Next"
    var labelColor: Color = .white
    var borderColor: Color?
    var image: Image?
    var textSize: CGFloat?
    
    var body: some View {
        Group {
            if borderColor != nil {
                Button {
                    onButtonPressed()
                } label: {
                    HStack(spacing: 12) {
                        if let image {
                            image
                        }
                        if let textSize {
                            Text(buttonLabel)
                                .stingerRegularFont(size: textSize)
                        } else {
                            Text(buttonLabel)
                        }
                    }
                }
                .primaryBorderedButtonStyle(buttonColor: borderColor ?? .black, labelColor: labelColor)
            } else {
                Button {
                    onButtonPressed()
                } label: {
                    HStack(spacing: 12) {
                        if let image {
                            image
                        }
                        if let textSize {
                            Text(buttonLabel)
                                .stingerRegularFont(size: textSize)
                        } else {
                            Text(buttonLabel)
                        }
                    }
                }
                .primaryButtonStyle(buttonColor: buttonColor, labelColor: labelColor)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        
        PrimaryBtn(onButtonPressed: {})
    }
}
