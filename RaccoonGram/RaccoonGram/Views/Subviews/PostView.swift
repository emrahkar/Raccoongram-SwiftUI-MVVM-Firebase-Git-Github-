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
    @State var postImage: UIImage = UIImage(named: "raccoon1")!
    @State var animateLike: Bool = false
    @State var addheartAnimationToView: Bool
    @State var showActionSheet: Bool = false
    @State var actionSheetType: PostActionSheetOption = .general
    
    enum PostActionSheetOption {
        case general
        case reporting
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            //MARK: HEADER
            
            if showHeaderAndFooter {
                HStack {
                    
                    NavigationLink {
                        ProfileView(ismyProfile: false, profileDisplayName: post.username, profileUserID: post.userID)
                    } label: {
                        Image(uiImage: postImage)
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
                    
                    Button {
                        showActionSheet.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.headline)
                    }
                    .accentColor(.primary)
                    .actionSheet(isPresented: $showActionSheet, content: {
                         getActionSheet()
                    })

                }
                .padding(.all, 6)
                
            }
           
            //MARK: IMAGE
            ZStack {
            Image("raccoon1")
                .resizable()
                .scaledToFit()
            
                if addheartAnimationToView {
                    LikeAnimationView(animate: $animateLike)
                }
                
            }
            
            //MARK: FOOTER
            
            if showHeaderAndFooter {
                HStack(alignment: .center, spacing: 20) {
                    Button {
                        if post.likedByUser {
                            unlikePost()
                        } else {
                            likePost()
                        }
                    } label: {
                        Image(systemName: post.likedByUser ? "heart.fill" : "heart")
                            .font(.title3)
                    }
                    .accentColor(post.likedByUser ? .red : .primary)

                    
                    //MARK: COMMENTS
                    
                    NavigationLink {
                        CommentsView()
                    } label: {
                        Image(systemName: "bubble.middle.bottom")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }

                    
                    Button {
                        sharePost()
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.title3)
                    }
                    .accentColor(.primary)

                    
                    
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
    
    //MARK: FUNCTIONS
    
    func likePost() {
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, dateCreated: post.dateCreated, likeCount: post.likeCount + 1, likedByUser: true)
        
        animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            animateLike = false
        }
        
        self.post = updatedPost
    }
    
    func unlikePost() {
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, dateCreated: post.dateCreated, likeCount: post.likeCount - 1, likedByUser: false)
    
        
        self.post = updatedPost
        
    }
    
    func getActionSheet() -> ActionSheet {
        
        switch self.actionSheetType {
            case .general:
            return ActionSheet(title: Text("What would you like to do?"), message: nil, buttons: [
                .destructive(Text("Report"), action: {
                    self.actionSheetType = .reporting
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showActionSheet.toggle()
                    }
                    
                }),
                .default(Text("Learn more..."), action: {
                    print("LEEARN MORE PRESSED")
                }),
                .cancel()
            ])
            
        case .reporting:
            return ActionSheet(title: Text("Why are you reporting this post?"), message: nil, buttons: [
                .destructive(Text("This is imappropriate"), action: {reportPost(reason: "this is inappropriate")}),
                .destructive(Text("This is spam"), action: {reportPost(reason: "this is spam")}),
                .destructive(Text("This is uncomfortable"), action: {reportPost(reason: "this is uncomfortable")}),
                
                 .cancel({
                    self.actionSheetType = .general
                })
            
            ])
            
        }
        
    }
    
    func reportPost(reason: String) {
        print("REPORT POST NOW")
    }
    
    func sharePost() {
        
        let message = "Check out this post on RaccoonGram"
        let image = postImage
        let link = URL(string: "https://www.google.com")!
        
        let activityViewController = UIActivityViewController(activityItems: [message, image, link], applicationActivities: nil)
        
        let viewController = UIApplication.shared.windows.first?.rootViewController
        viewController?.present(activityViewController, animated: true, completion: nil)
    }
}

struct PostView_Previews: PreviewProvider {
    
    static var post: PostModel = PostModel(postID: "", userID: "", username: "Joe Green", caption: "This is test", dateCreated: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true, addheartAnimationToView: true)
            .previewLayout(.sizeThatFits)
    }
}
