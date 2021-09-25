//
//  ContentView.swift
//  Tarea6
//
//  Created by Luis Mora Rivas on 24/9/21.
//

import SwiftUI

struct ContentView: View {
    var model = [RedditModel]()
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(self.model) {post in
                    VStack {
                        HStack{
                            Text(post.data.author)
                            Text(post.data.title)
                        }
                        
                    }
                }
            }
            .navigationBarTitle("Courses")
            .navigationBarItems(trailing: Button(
                action: {
                    print("Fetching json data")
                },
                label: {
                    Text("Fetch Courses")
                }
            ))
        }
    }
    
    private func getRedditPost() {
        GenericViewModel<[RedditModel]>.httpGet(path: "data.children", url: "https://www.reddit.com/top.json?limit=50") { (posts) in
            DispatchQueue.main.async() {
                model = posts
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
