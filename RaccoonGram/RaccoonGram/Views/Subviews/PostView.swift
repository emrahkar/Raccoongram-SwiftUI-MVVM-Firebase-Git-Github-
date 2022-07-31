//
//  PostView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 28.07.2022.
//

import SwiftUI

struct PostView: View {
    
    
    @State var post: PostModel
    @State var showHeaderAndFooter: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            //MARK: HEADER
            
            if showHeaderAndFooter {
                HStack {
                    
                    NavigationLink {
                        ProfileView(ismyProfile: false, profileDisplayName: post.username, profileUserID: post.userID)
                    } label: {
                        Image("raccoon1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30, alignment: .center)
                            .cornerRadius(15)
                        
                        Text(post.username)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }

                    
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .font(.headline)
                }
                .padding(.all, 6)
                
            }
           
            //MARK: IMAGE
            Image("raccoon1")
                .resizable()
                .scaledToFit()
            
            //MARK: FOOTER
            
            if showHeaderAndFooter {
                HStack(alignment: .center, spacing: 20) {
                    Image(systemName: "heart")
                        .font(.title3)
                    
                    NavigationLink {
                        CommentsView()
                    } label: {
                        Image(systemName: "bubble.middle.bottom")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }

                    
                    Image(systemName: "paperplane")
                        .font(.title3)
                    
                    Spacer()
                }
                .padding(.all, 6)
                
                if let caption = post.caption {
                    HStack{
                        Text(caption)
                        Spacer(minLength: 0)
                    }
                    .padding(.all, 6)
                }
                
            }
           
            
            
        }
    }
}

struct PostView_Previews: PreviewProvider {
    
    static var post: PostModel = PostModel(postID: "", userID: "", username: "Joe Green", caption: "This is test", dateCreated: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true)
            .previewLayout(.sizeThatFits)
    }
}
