//
//  OnboardingView.swift
//  RestartApp
//
//  Created by Justin Hold on 6/20/23.
//

import SwiftUI

struct OnboardingView: View {
	
	// MARK: - PROPERTIES
	@AppStorage("onboarding") var isOnboardingViewActive = true
	@State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
	@State private var buttonOffset: CGFloat = 0
	@State private var isAnimating = false
	@State private var imageOffset: CGSize = .zero
	@State private var indicatorOpacity: Double = 1.0
	@State private var textTitle: String = "Share."
	
	let hapticFeedback = UINotificationFeedbackGenerator()
	
	// MARK: - BODY
    var body: some View {
		
		
		// MARK: - BACKGROUND
		ZStack {
			Color("ColorBlue")
				.ignoresSafeArea()
			
			// MARK: - HEADER
			VStack(spacing: 20) {
				Spacer()
				VStack(spacing: 0) {
					Text(textTitle)
						.font(.system(size: 60))
						.fontWeight(.heavy)
						.foregroundColor(.white)
						.transition(.opacity)
						.id(textTitle)
					
					Text("""
					It's not how much we give but
					how much love we put into giving.
					""")
					.font(.title3)
					.fontWeight(.light)
					.foregroundColor(.white)
					.multilineTextAlignment(.center)
					.padding(.horizontal, 10)
				} //: END OF INNER VSTACK
				.opacity(isAnimating ? 1: 0)
				.offset(y: isAnimating ? 0 : -40)
				.animation(.easeOut(duration: 1), value: isAnimating)
				
				// MARK: - CENTER
				ZStack {
					ZStack {
						CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
							.offset(x: imageOffset.width * -1)
							.blur(radius: abs(imageOffset.width / 5))
							.animation(.easeOut(duration: 1), value: imageOffset)
					} //: END OF INNER ZSTACK
					
					Image("character-1")
						.resizable()
						.scaledToFit()
						.opacity(isAnimating ? 1 : 0)
						.animation(.easeOut(duration: 0.5), value: isAnimating)
						.offset(x: imageOffset.width * 1.2, y: 0)
						.rotationEffect(.degrees(Double(imageOffset.width / 20)))
						.gesture(
							DragGesture()
								.onChanged { gesture in
									if abs(imageOffset.width) <= 150 {
										imageOffset = gesture.translation
										withAnimation(.linear(duration: 0.25)) {
											indicatorOpacity = 0
											textTitle = "Give."
										}
									}
								}
								.onEnded { _ in
									imageOffset = .zero
									withAnimation(.linear(duration: 0.25)) {
										indicatorOpacity = 1
										textTitle = "Share."
									}
								}
						) //: END OF GESTURE
						.animation(.easeOut(duration: 1), value: imageOffset)
				} //: END OF CENTER ZSTACK
				.overlay(
					Image(systemName: "arrow.left.and.right.circle")
						.font(.system(size: 44, weight: .ultraLight))
						.foregroundColor(.white)
						.offset(y: 40)
						.opacity(isAnimating ? 1 : 0)
						.animation(.easeOut(duration: 1).delay(2), value: isAnimating)
						.opacity(indicatorOpacity)
					, alignment: .bottom
				)
				Spacer()
				
				// MARK: - FOOTER
				ZStack {
					// Parts of the custom button
					
					// 1. Background (Static)
					Capsule()
						.fill(Color.white.opacity(0.2))
					Capsule()
						.fill(Color.white.opacity(0.2))
						.padding(8)
					
					// 2. Call-To-Action (Static)
					Text("Get Started")
						.font(.system(.title3, design: .rounded))
						.fontWeight(.bold)
						.foregroundColor(.white)
						.offset(x: 20)
					
					// 3. Capsule (Dynamic Width)
					HStack {
						Capsule()
							.fill(Color("ColorRed"))
							.frame(width: buttonOffset + 80)
						Spacer()
					} //: END OF BUTTON HSTACK
					
					// 4. Circle (Draggable)
					HStack {
						ZStack {
							Circle()
								.fill(Color("CircleRed"))
							Circle()
								.fill(.black.opacity(0.15))
								.padding(8)
							Image(systemName: "chevron.right.2")
								.font(.system(size: 24, weight: .bold))
						}
						.foregroundColor(.white)
						.frame(width: 80, height: 80, alignment: .center)
						.offset(x: buttonOffset)
						.gesture(
							DragGesture()
								.onChanged { gesture in
									if gesture.translation.width > 0 && buttonOffset  <= buttonWidth - 80 {
										buttonOffset = gesture.translation.width
									}
								} //: END OF onChanged
								.onEnded { _ in
									withAnimation(Animation.easeOut(duration: 0.4)) {
										if buttonOffset > buttonWidth / 2 {
											hapticFeedback.notificationOccurred(.success)
											playSound(sound: "chimeup", type: "mp3")
											buttonOffset = buttonWidth - 80
											isOnboardingViewActive = false
										} else {
											hapticFeedback.notificationOccurred(.warning)
											buttonOffset = 0
										}
									}
								} //: END OF onEnded
						) //: END OF GESTURE
						Spacer()
					} //: END OF CIRCLE HSTACK
				} //: END OF FOOTER ZSTACK
				.frame(width: buttonWidth, height: 80, alignment: .center)
				.padding()
				.opacity(isAnimating ? 1 : 0)
				.offset(y: isAnimating ? 0 : 40)
				.animation(.easeOut(duration: 1), value: isAnimating)
			} //: END OF HEADER VSTACK
		} //: END OF BODY ZSTACK
		.onAppear(perform: {
			isAnimating = true
		})
		.preferredColorScheme(.dark)
    }
}

// MARK: - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
