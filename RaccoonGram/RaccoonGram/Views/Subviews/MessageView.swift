//
//  MessageView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 29.07.2022.
//

import SwiftUI

struct MessageView: View {
    
    @State var comment: CommentModel
    
    var body: some View {
        
        HStack{
            
            //MARK: Profile Image
            
            Image("raccoon1")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 3) {
                
                //MARK: USERNAME
                
                Text(comment.username)
                        .font(.caption)
                        .foregroundColor(.gray)
                
                //MARK: CONTENT
                Text(comment.content)
                    .padding(.all, 10)
                    .foregroundColor(.primary)
                    .background(Color.MyTheme.lavenderColor)
                    .cornerRadius(10)
                    
            }
            
            Spacer(minLength: 0)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    
    static var comment: CommentModel = CommentModel(commentID: "", userID: "", username: "Emrah", content: "This is so cool", dateCreated: Date())
    static var previews: some View {
        MessageView(comment: comment)
            .previewLayout(.sizeThatFits)
    }
}
