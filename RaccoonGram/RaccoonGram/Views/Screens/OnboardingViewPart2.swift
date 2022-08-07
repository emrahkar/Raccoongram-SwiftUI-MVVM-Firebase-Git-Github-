//
//  OnboardingViewPart2.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 2.08.2022.
//

import SwiftUI

struct OnboardingViewPart2: View {
    
    @State var displayName: String = "Emrah"
    @State var showImagePicker: Bool = false
    
    //FOr image picket
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            Text("What's your name?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.MyTheme.lavenderColor)
            
            TextField("Add your name here...", text: $displayName)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.MyTheme.beigeColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .padding(.horizontal)
            
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Finish: Add profile picture")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.lavenderColor)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .accentColor(Color.MyTheme.tealColor)
            .opacity(displayName != "" ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 1.0))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.tealColor)
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showImagePicker, onDismiss: createProfile) {
            ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
        }
        
    }
    
    //MARK: FUNCTIONS
    
    func createProfile() {
        print("Create Profile")
    }
}

struct OnboardingViewPart2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingViewPart2()
    }
}
