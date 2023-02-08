//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kalle Pohjanjoki on 6.2.2023.
//

import SwiftUI

struct ContentView: View {
	
	@State private var scoreCount = 0
	
	@State private var showingScore = false
	@State private var scoreTitle = ""
	
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	
	@State private var correctAnswer = Int.random(in: 0...2)
	
	var body: some View {
		ZStack {
			
			RadialGradient(stops: [.init(color: .blue, location: 0.3), .init(color: .pink, location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
				.ignoresSafeArea()
			
			VStack {
				
				Spacer()
				
				Text("Guess The Flag")
					.font(.largeTitle.weight(.bold))
				
				VStack(spacing: 15) {
					VStack{
						Text("Tap the flag of")
							.foregroundStyle(.secondary)
							.font(.subheadline.weight(.heavy))
						Text(countries[correctAnswer])
							.foregroundColor(.black)
							.font(.largeTitle.weight(.semibold))
					}
					
					
					ForEach(0..<3) { number in
						Button {
							flagTapped(number)
						} label: {
							Image(countries[number])
								.renderingMode(.original)
								.clipShape(Capsule())
								.shadow(radius: 5)
						}
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 20)
				.background(.regularMaterial)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				
				Spacer()
				Spacer()
				
				Text("Score: \(scoreCount)")
					.font(.title.bold())
				Spacer()
			}
			.padding()
			
			
		}
		.alert(scoreTitle, isPresented: $showingScore) {
			Button("Continue", action: askQuestion)
		} message: {
			Text("Your score is \(scoreCount)")
		}
		
		
		
	}
	
	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			scoreTitle = "Correct"
			scoreCount += 1
		} else {
			scoreTitle = "Wrong"
		}
		
		showingScore = true
	}
	
	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
