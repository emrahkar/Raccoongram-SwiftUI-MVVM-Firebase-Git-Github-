//
//  OnboardingView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 2.08.2022.
//

import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showOnBoardingPart2: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("Welcome to RaccoonGram")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.MyTheme.tealColor)
            
            Text("This is the best app to post a raccoon picture and share with friends, family and othe people! We ould be very happy to have you here and see your amazing Raccoon Pics!")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.MyTheme.tealColor)
                .padding()
            
            Button {
                showOnBoardingPart2.toggle()
            } label: {
                SignInWithAppleButtonCustom()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
            }
            
            Button {
                showOnBoardingPart2.toggle()
            } label: {
                HStack{
                    Image(systemName: "globe")
                    Text("Sign in with Google")
                        
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color(.sRGB, red: 222/255, green: 82/255, blue: 70/255, opacity: 1.0))
                .cornerRadius(6)
                .font(.system(size: 23, weight: .medium, design: .default))
            }
            .accentColor(Color.white)
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Continue as guest")
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding()
            }
            .accentColor(Color.black)



        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.beigeColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnBoardingPart2) {
            OnboardingViewPart2()
        }

    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
