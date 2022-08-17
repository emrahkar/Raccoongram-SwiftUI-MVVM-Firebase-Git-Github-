//
//  ProfileView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 31.07.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var ismyProfile: Bool
    @State var profileDisplayName: String
    var profileUserID: String
  
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    
    
    
    var posts = PostArrayObject()
    
    @State var showSettings: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ProfileHeaderView(profileDisplayName: $profileDisplayName, profileImage: $profileImage)
            Divider()
            ImageGridView(posts: posts)
        }
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    showSettings.toggle()
                                }, label: {
                                    Image(systemName: "line.horizontal.3")
                                })
                                .accentColor(colorScheme == .light ? Color.MyTheme.tealColor : Color.MyTheme.lavenderColor)
                                .opacity(ismyProfile ? 1.0 : 0.0)
        )
        .onAppear(perform: {
            getProfileImage()
        })
        .sheet(isPresented: $showSettings) {
            SettingsView()
                .preferredColorScheme(colorScheme)
        }
    }
    
    //MARK: FUNCTIONS
    
    func getProfileImage() {
        ImageManager.instance.downloadProfileImage(userID: profileUserID) { (returnedImage) in
            if let image = returnedImage {
                self.profileImage = image
            }
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileView(ismyProfile: true, profileDisplayName: "Joe", profileUserID: "")
        }
        .preferredColorScheme(.dark)
    }
}
