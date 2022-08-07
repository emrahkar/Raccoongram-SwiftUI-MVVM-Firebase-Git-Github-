//
//  SignInWithAppleButtonCustom.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 2.08.2022.
//

import Foundation
import SwiftUI
import AuthenticationServices // to access button

struct SignInWithAppleButtonCustom: UIViewRepresentable {   //USED TO CONVERT THINGS FROM UIKIT TO SWIFTUI
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .default, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) { }
    
}
