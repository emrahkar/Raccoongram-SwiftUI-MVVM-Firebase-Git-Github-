//
//  ContentView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 26.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
 
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?
  
    
    let feedPosts = PostArrayObject(shuffled: false)
    let browsePosts = PostArrayObject(shuffled: true)
    
    var body: some View {
        
        TabView{
            NavigationView{
                FeedView(posts: feedPosts, title: "Feed")
            }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            
            NavigationView {
                BrowseView(posts: browsePosts)
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Browse")
                }
            
            UploadView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }
            
            ZStack{
                if let userID = currentUserID, let displayName = currentUserDisplayName {
                    NavigationView {
                        ProfileView(ismyProfile: true, profileDisplayName: displayName, profileUserID: userID, posts: PostArrayObject(userID: userID))
                    }
                } else {
                    SignUpView()
                }
            }
                .tabItem {
                    Image(systemName: "pawprint.fill")
                    Text("Profile")
                }
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.tealColor : Color.MyTheme.lavenderColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
