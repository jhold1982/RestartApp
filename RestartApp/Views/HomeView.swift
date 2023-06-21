//
//  HomeView.swift
//  RestartApp
//
//  Created by Justin Hold on 6/20/23.
//

import SwiftUI

struct HomeView: View {
	
	// MARK: - PROPERTIES
	@AppStorage("onboarding") var isOnboardingViewActive = false
	@State private var isAnimating = false
	
	// MARK: - BODY
    var body: some View {
		VStack(spacing: 20) {
			
			// MARK: - HEADER
			Spacer()
			ZStack {
				CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)
				Image("character-2")
					.resizable()
					.scaledToFit()
					.padding()
					.offset(y: isAnimating ? 35 : -35)
					.animation(
						Animation
							.easeInOut(duration: 4)
							.repeatForever(), value: isAnimating
					)
			} //: END OF IMAGE ZSTACK
			
			// MARK: - CENTER
			Text("The time that leads is dependent on the intensity of our focus.")
				.font(.title3)
				.fontWeight(.bold)
				.foregroundColor(.secondary)
				.multilineTextAlignment(.center)
				.padding()
			
			// MARK: - FOOTER
			Spacer()
			Button(action: {
				withAnimation {
					playSound(sound: "success", type: "m4a")
					isOnboardingViewActive = true
				}
			}) {
				Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
					.imageScale(.large)
				Text("Restart")
					.font(.system(.title3, design: .rounded))
					.fontWeight(.bold)
			} //: END OF BUTTON
			.buttonStyle(.borderedProminent)
			.buttonBorderShape(.capsule)
			.controlSize(.large)
		} //: END OF BODY ZSTACK
		.onAppear(perform: {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
				isAnimating = true
			})
		})
    }
}

// MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
