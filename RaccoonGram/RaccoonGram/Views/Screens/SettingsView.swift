//
//  SettingsView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 1.08.2022.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State var showSignOutError: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                //MARK: SECTION 1 DOGGRAM
                GroupBox(content: {
                    HStack(alignment: .center, spacing: 10) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(12)
                        
                        Text("This is the best app to post a raccoon picture and share with friends, family and othe people! We ould be very happy to have you here and see your amazing Raccoon Pics!")
                            .font(.footnote)
                    }
                }, label: {
                    SettingsLabelView(labelText: "RaccoonGram", labelImage: "dot.radiowaves.left.and.right")
                })
                .padding()
                
                //MARK: SECTION 2 PROFILE
                
                GroupBox {
                    
                    NavigationLink {
                        SettingsEditTextView(submissionText: "Current Display Name", title: "Display Name", description: "You can edit your display name here. This will be seen by other users on your profile and on your posts", placeholder: "Your Display Name here...")
                    } label: {
                        SettingsRowView(leftIcon: "pencil", text: "Display Name", color: Color.MyTheme.tealColor)
                    }
                    
                    NavigationLink {
                        SettingsEditTextView(submissionText: "Current Bio here", title: "Profile Bio", description: "Your Bio is a great place to let other users know a bit about you. It will be shown on your profile only", placeholder: "Your bio here...")
                    } label: {
                        SettingsRowView(leftIcon: "text.quote", text: "Bio", color: Color.MyTheme.tealColor)
                    }

                    NavigationLink {
                        SettingsEditImageView(title: "Profile Picture", description: "Your profile picture will be shown on your profile andon your posts. Most users make it an image of a raccoon!!!!!", selectedImage: UIImage(named: "raccoon1")!)
                    } label: {
                        SettingsRowView(leftIcon: "photo", text: "Profile Picture", color: Color.MyTheme.tealColor)
                    }

                   
                    Button {
                        signOut()
                    } label: {
                        SettingsRowView(leftIcon: "figure.walk", text: "Sign out", color: Color.MyTheme.tealColor)
                    }
                    .alert(isPresented: $showSignOutError) {
                        return Alert(title: Text("Error sign out"))
                    }

                    
                  

                    
                } label: {
                    SettingsLabelView(labelText: "Profile", labelImage: "person.fill")
                }
                .padding()
                
                //MARK: SECTION 3 APPLICATION
                
                GroupBox {
                    
                    Button {
                        openCustomURL(urlString: "https://www.google.com")
                    } label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Privacy Policy", color: Color.MyTheme.lavenderColor)
                    }
                    
                    Button {
                        openCustomURL(urlString: "https:// www.yahoo.com")
                    } label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Terms & Conditions", color: Color.MyTheme.lavenderColor)
                    }
                    
                    Button {
                        openCustomURL(urlString: "www.bing.com")
                    } label: {
                        SettingsRowView(leftIcon: "globe", text: "Website", color: Color.MyTheme.lavenderColor)
                    }



                 
                   
                    
                } label: {
                    SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")
                }
                .padding()
                
                //MARK: SECTION 4  SING OFF
                
                GroupBox {
                    Text("RaccoonGram app is made by me. \n All Rights Reserved. \n Emrah App Inc. \n Copyright 2022🥳")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .padding(.bottom, 80)

        
            }
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading:
                                    Button(action: {
                                        
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .font(.title)
                                    })
                                    .accentColor(.primary)
            
                                    )
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.tealColor : Color.MyTheme.lavenderColor)
    }
    
    //MARK: FUNCTIONS
    
    func openCustomURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func signOut() {
        AuthService.instance.logOutUser { success in
            if success {
                print("Successfully log out")
                self.presentationMode.wrappedValue.dismiss()
                
                // update userdefaults
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
                    defaultsDictionary.keys.forEach { key in
                        UserDefaults.standard.removeObject(forKey: key)
                    }
                    
                }
            } else {
                print("Error logging out")
                self.showSignOutError.toggle()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.light)
    }
}
