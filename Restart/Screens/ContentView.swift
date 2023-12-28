//
//  ContentView.swift
//  Restart
//
//  Created by Mateus Benilson Martins Fernandes on 28/12/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @AppStorage("onboarding") var isOnboardingActive: Bool = true
    
    var body: some View {
        
        
        ZStack {
            if isOnboardingActive {
                OnboardingView()


            } else {
                HomeView()

            }
        }
    }}

#Preview {
    ContentView()
}
