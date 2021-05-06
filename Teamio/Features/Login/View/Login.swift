//
//  Login.swift
//  Teamio
//
//  Created by Kamran Ramzan on 05/05/2021.
//

import Foundation
import SwiftUI

struct Login: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State var selection: Int? = nil
    @State var showView = false
    
    /// Login Properties
    @EnvironmentObject var session: AuthViewModel
    @State var loading = false
    @State var error = false
    
    var body: some View {
        NavigationView {
            VStack(content: {
                /// App icon
                Image("ic_teamio")
                    .padding(.init(top: 60, leading: 0, bottom: 0, trailing: 0))
                Text("Sign in to your Account")
                    .font(.custom("Hellix-Bold", size: 30)).foregroundColor(Color.black).padding(.horizontal, 16)
                    .padding(.top, 36)
                
                /// Email field
                RoundedTextField(hint: "Email", icon: Image("ic_email"),email: $email).padding(.top, 32)
                
                /// Password field
                SecureTextField(hint: "Password", icon: Image("ic_lock"),email: $password).padding(.top, 16)
                
                if loading {
                    Text("Loggin in...").font(.custom("Hellix-Regular", size: 16)).padding(.vertical, 16)
                } else {
                    /// Navigation Link to Home for Testing purpose
                    NavigationLink(
                        destination: Home().environmentObject(session),
                        tag: 1, selection: $selection)  {
                        Button(action: {
                            self.signIn()
                        }) {
                            Text("Sign in")
                                .fontWeight(.semibold)
                                .font(.custom("Hellix-SemiBold", size: 18))
                                .padding(.horizontal, 48)
                                .padding(.vertical, 20)
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [.init(hex: "#6FCDD6"), .init(hex: "#3CB187")]), startPoint: .topTrailing, endPoint: .bottomLeading))
                                .cornerRadius(40)
                                .padding(.top, 60)
                        }
                        }
                }
                HStack(content: {
                    Text("Don't have a teamio account yet?")
                        .font(.custom("Hellix-Regular", size: 18))
                    NavigationLink(
                        destination: Signup(showView: self.$showView),
                        isActive: self.$showView,
                        label: {
                            Text("Signup")
                                .font(.custom("Hellix-SemiBold", size: 18)).foregroundColor(Color.black)
                        })
                }).padding(.horizontal, 16)
                Spacer()
            })
        }.navigationBarHidden(true)
    }
    
    /// Signing in the user and setting the state of app
    func signIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
                self.selection = 1
            }
        }
    }
}

struct RoundedTextField: View {
    
    var hint: String
    var icon: Image
    @Binding var email: String
    var body: some View {
        HStack {
            icon
            TextField(hint, text: $email)
                .font(.custom("Hellix-Regular", size: 12))
        }.padding(20)
        .keyboardType(.emailAddress)
        .background(Color.white)
        .cornerRadius(40)
        .disableAutocorrection(true)
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color.init(hex: "#4F4F4F"), lineWidth: 0.25)).padding(.horizontal)
        
    }
}

struct SecureTextField: View {
    
    var hint: String
    var icon: Image
    @Binding var email: String
    var body: some View {
        HStack {
            icon
            SecureField(hint, text: $email)
                .font(.custom("Hellix-Regular", size: 12))        }.padding(20)
            .keyboardType(.default)
            .background(Color.white)
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.init(hex: "#4F4F4F"), lineWidth: 0.25)).padding(.horizontal)
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
