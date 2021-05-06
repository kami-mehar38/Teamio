//
//  Post.swift
//  Teamio
//
//  Created by Kamran Ramzan on 06/05/2021.
//

import Foundation

struct Post: Identifiable {
    
    var id: String = UUID().uuidString
    var date: String
    var name: String
    var post: String
}
