//
//  CommentsView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 29.07.2022.
//

import SwiftUI

struct CommentsView: View {
    
    @State var submissionText: String = ""
    @State var commentArray = [CommentModel]()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack{
                    ForEach(commentArray, id: \.self) { comment in
                        MessageView(comment: comment)
                    }
                    
                }
                .padding(.all, 6)
            }
            
            HStack {
                Image("raccoon1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                
                TextField("Add a comment here...", text: $submissionText)
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                }
                .accentColor(Color.MyTheme.tealColor)
            }
            .padding(.all, 6)
        }
        .navigationBarTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            getComments()
        }
    }
    
    // MARK; FUNCTIONS
    
    func getComments() {
        
        print("Get comments form Database")
        
        let comment1 = CommentModel(commentID: "", userID: "", username: "Emrah", content: "First comment", dateCreated: Date())
        let comment2 = CommentModel(commentID: "", userID: "", username: "Handan", content: "Second comment", dateCreated: Date())
        let comment3 = CommentModel(commentID: "", userID: "", username: "Sami", content: "Third comment", dateCreated: Date())
        let comment4 = CommentModel(commentID: "", userID: "", username: "Yeliz", content: "Fourth comment", dateCreated: Date())
        
        self.commentArray.append(comment1)
        self.commentArray.append(comment2)
        self.commentArray.append(comment3)
        self.commentArray.append(comment4)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CommentsView()
        }
    }
}
