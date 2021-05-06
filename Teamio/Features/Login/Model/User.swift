//
//  User.swift
//  Teamio
//
//  Created by Kamran Ramzan on 06/05/2021.
//

class User {
    var uid: String
    var email: String?
    var displayName: String?

    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }

}
