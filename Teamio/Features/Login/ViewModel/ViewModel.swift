//
//  AuthenticationService.swift
//  Teamio
//
//  Created by Kamran Ramzan on 06/05/2021.
//

import SwiftUI
import Firebase
import Combine

class AuthViewModel : ObservableObject {
    var didChange = PassthroughSubject<AuthViewModel, Never>()
    var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen () {
        /// monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName, email: user.email
                )
            } else {
                /// if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    /// We can also sign out using the following function, as our app is not having the
    /// functionality of logout so this function is not beign used
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    /// Used to unbind the auth state change listener
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
