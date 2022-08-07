//
//  SignUpView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 2.08.2022.
//

import SwiftUI

struct SignUpView: View {
    
    @State var showOnBoarding: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            Spacer()
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("You are not signed in 🐾")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.MyTheme.tealColor)
            
            Text("Click the button below to creat an raccoon account! 🐾🐾🐾")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.MyTheme.tealColor)
            
            Button {
                showOnBoarding.toggle()
            } label: {
                Text("Sign in/Sign up".uppercased())
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.MyTheme.tealColor)
                        .cornerRadius(12)
                        .shadow(radius: 12)
            }
            .accentColor(Color.MyTheme.lavenderColor)
            Spacer()
            Spacer()
        }
        .padding(.all, 40)
        .background(Color.MyTheme.lavenderColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnBoarding) {
            OnboardingView()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
