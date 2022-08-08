//
//  OnboardingView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 2.08.2022.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct OnboardingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var showOnBoardingPart2: Bool = false
    @State var isLoading: Bool = false
   
    
    
    
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
            
            //MARK: SIGN IN WITH APPLE
            
            Button {
                showOnBoardingPart2.toggle()
            } label: {
                SignInWithAppleButtonCustom()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
            }
            
            //MARK: SIGN IN WITH GOOGLE
            
            Button {
                handleLogin()
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
        .overlay(
        
            ZStack{
                if isLoading{
                    Color.black
                        .opacity(0.25)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .font(.title2)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        
        )
        
    }
    
    func handleLogin() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        isLoading = true
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) { [self] user, error in
            if let error = error {
                isLoading = false
                print(error.localizedDescription)
                return
              }

              guard
                let fullname: String = user?.profile?.name,
                let email: String = user?.profile?.email,
                let authentication = user?.authentication,
                let idToken = authentication.idToken
              else {
                  isLoading = false
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)
            
            //FireBase Auth
            Auth.auth().signIn(with: credential) { result, error in
                
                isLoading = false
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                  }
                
                //Displaying User Name
                
                guard let user = result?.user else {
                    return
                }
                
                print(user.displayName ?? "Success")
                
                self.showOnBoardingPart2.toggle()
                
            }
        }
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

//Extending View to get screen bounds
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    //Retreiving RootView Controller
    
    func getRootViewController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
