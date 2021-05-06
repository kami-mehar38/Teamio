//
//  SignUp.swift
//  Teamio
//
//  Created by Kamran Ramzan on 05/05/2021.
//

import Foundation
import SwiftUI

struct Signup: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State var selection: Int? = nil
    
    /// Sign up Properties
    @EnvironmentObject var session: AuthViewModel
    @State var loading = false
    
    /// State Config
    @State var passwordMismatch:Bool = false
    
    @Binding var showView : Bool
    var body: some View {
        NavigationView {
            VStack(content: {
                Image("ic_teamio")
                    .padding(.init(top: 60, leading: 0, bottom: 0, trailing: 0))
                Text("Create your Account")
                    .font(.custom("Hellix-Bold", size: 30)).foregroundColor(Color.black).padding(.horizontal, 16)
                    .padding(.top, 36)
                
                /// Name Field
                CustomTextField(hint: "Name",email: $name).padding(.top, 32)
                
                /// Name Field
                CustomTextField(hint: "Email",email: $email).padding(.top, 16)
                
                /// Password Field
                PasswordTextField(hint: "Password", passwordMismatch: $passwordMismatch,email: $password).padding(.top, 16)
                
                /// Password Field
                PasswordTextField(hint: "Confirm Password", passwordMismatch: $passwordMismatch,email: $confirmPassword).padding(.top, 16)
                
                /// Sign in button
                if loading {
                    Text("Signin up...").font(.custom("Hellix-Regular", size: 16)).padding(.vertical, 16)
                } else {
                    /// Navigation Link to Home for Testing purpose
                    NavigationLink(
                        destination: Home().environmentObject(session),
                        tag: 1, selection: $selection)  {
                        Button(action: {
                            self.signUp()
                        }) {
                            Text("Sign up")
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
                
                /// Already have account
                HStack(content: {
                    Text("Already have account?")
                        .font(.custom("Hellix-Regular", size: 18))
                    Button(action: {
                        self.showView = false
                    }, label: {
                        Text("Sign in")
                            .font(.custom("Hellix-SemiBold", size: 18))
                    })
                }).foregroundColor(Color.black)
                Spacer()
            })
        }.navigationBarHidden(true)
    }
    
    func signUp () {
        if password != confirmPassword {
            passwordMismatch = true
        } else {
            loading = true
            passwordMismatch = false
            session.signUp(email: email, password: password) { (result, error) in
                self.loading = false
                if error != nil {
                    self.passwordMismatch = true
                } else {
                    self.email = ""
                    self.password = ""
                    self.selection = 1
                }
            }
        }
    }
}

struct CustomTextField: View {
    var hint: String
    @Binding var email: String
    var body: some View {
        TextField(hint, text: $email)
            .font(.custom("Hellix-Regular", size: 12)).padding(20)
            .keyboardType(.emailAddress)
            .background(Color.white)
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.init(hex: "#4F4F4F"), lineWidth: 0.25)).padding(.horizontal)
        
    }
}

struct PasswordTextField: View {
    var hint: String
    @Binding var passwordMismatch: Bool
    @Binding var email: String
    var body: some View {
        TextField(hint, text: $email)
            .font(.custom("Hellix-Regular", size: 12)).padding(20)
            .keyboardType(.emailAddress)
            .background(Color.white)
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(passwordMismatch ? Color.red : Color.init(hex: "#4F4F4F"), lineWidth: 0.25)).padding(.horizontal)
        
    }
}



struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
