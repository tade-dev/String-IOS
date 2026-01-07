//
//  HomeViewModel.swift
//  String-IOS
//
//  Created by BSTAR on 02/01/2026.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var selectedUser: CardData?
    @Published var triggerSwipe: SwipeDirection?
    @Published var showMatchedScreen: Bool = false
    
    func swipeCard(direction: SwipeDirection) {
        triggerSwipe = direction
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.triggerSwipe = nil
        }
    }
    
}
