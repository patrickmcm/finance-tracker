//
//  LoginView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 02/09/2026.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                Image(systemName: "building.columns.circle.fill")
                    .font(.system(size: 80))
                Text("Portfolio Manager")
            }
            .font(.title)
            .bold()
            Spacer()
            
            HStack {
                SignInWithAppleButton(onRequest: {(the : ASAuthorizationAppleIDRequest) -> Void in return}, onCompletion: {(the: Result<ASAuthorization, any Error>) -> Void in return})
            }
            .frame(height:44)
            .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    LoginView()
}
