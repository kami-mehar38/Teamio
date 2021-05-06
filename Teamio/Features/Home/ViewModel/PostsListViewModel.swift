//
//  PostsListViewModel.swift
//  Teamio
//
//  Created by Kamran Ramzan on 06/05/2021.
//


import Combine
import FirebaseFirestore

class PostsListViewModel: ObservableObject {
    
    /// This field defines the path of posts in Firestore Database
    private let path: String = "posts"
    
    /// Firestore Instance
    private let store = Firestore.firestore()
    
    @Published var posts: [Post] = []
    
    func get() {
        store.collection(path).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.posts = documents.map { (queryDocumentSnapshot) -> Post in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let post = data["post"] as? String ?? ""
                let id = data["id"] as? String ?? ""
                print("POST NAME \(data["name"])")
                return Post(id: id, date: "asd", name: name, post: post)
            }
        }
    }
    func add(_ post: Post) {
        
    }
}
