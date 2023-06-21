//
//  ContentView.swift
//  RestartApp
//
//  Created by Justin Hold on 6/20/23.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - PROPERTIES
	@AppStorage("onboarding") var isOnboardingViewActive = true
	
	
	// MARK: - BODY
    var body: some View {
		ZStack {
			if isOnboardingViewActive {
				OnboardingView()
			} else {
				HomeView()
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
