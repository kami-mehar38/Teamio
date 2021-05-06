//
//  Home.swift
//  Teamio
//
//  Created by Kamran Ramzan on 06/05/2021.
//

import SwiftUI
import FirebaseAuth

struct Home: View {
    /// It is an ObjsevedPbject property wrapper which is used to Observe any 'Obseved' object
    @ObservedObject var postsViewModel: PostsListViewModel
    
    /// State property wrapper
    @State var tweet: String = ""
    
    init() {
        postsViewModel = PostsListViewModel()
        UITableViewCell.appearance().backgroundColor = .white
        UITableView.appearance().backgroundColor = .white
    }
    
    var body: some View {
        NavigationView {
            if postsViewModel.posts.isEmpty {
                Text("Loading...").font(.caption)
            } else {
                VStack {
                    HStack {
                        
                        Image("ic_teamio_small")
                    }.padding(.top, 16)
                    
                    /// Top space line
                    Rectangle().frame(height: 0.25).foregroundColor(Color.init(hex: "#4F4F4F")).padding(.horizontal, 16).padding(.bottom, 4).padding(.top, 12)
                    
                    /// List which is listening to the posts available in database
                    List(postsViewModel.posts) { post in
                        VStack(alignment: .leading) {
                            Text(post.name).font(.custom("Hellix-SemiBold", size: 18))
                            Text(post.post).font(.custom("Hellix-Regular", size: 16)).foregroundColor(Color.gray).padding(.top, 5)
                        }.listRowBackground(Color.white)
                    }.navigationBarHidden(true).listRowBackground(Color.white)
                    
                    /// Bottom space line
                    Rectangle().frame(height: 0.25).foregroundColor(Color.init(hex: "#4F4F4F")).padding(.horizontal, 16).padding(.bottom, 4)
                    
                    /// Message filed
                    HStack {
                        Image("ic_avatar")
                        TextField("Tweet you reply", text: $tweet)
                            .font(.custom("Hellix-Regular", size: 12)).padding(20)
                            .keyboardType(.emailAddress)
                            .background(Color.init(hex: "#E7ECF0"))
                            .cornerRadius(40)
                        Button(action: {
                            self.addPost()
                        }) {
                            Text("Send")
                                .fontWeight(.semibold)
                                .font(.custom("Hellix-SemiBold", size: 12))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [.init(hex: "#6FCDD6"), .init(hex: "#3CB187")]), startPoint: .topTrailing, endPoint: .bottomLeading))
                                .cornerRadius(40)
                        }
                    }.padding(.horizontal, 16)
                }
            }
        }.onAppear() {
            self.postsViewModel.get()
        }.navigationBarHidden(true)
    }
    
    func addPost() {
        if !tweet.isEmpty {
            postsViewModel.add(tweet)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

