//
//  RedditModel.swift
//  Tarea6
//
//  Created by Luis Mora Rivas on 24/9/21.
//

import Foundation

struct RedditModel: Identifiable, Codable {
    let kind: String
    let data: RedditPostModel
}

struct RedditPostModel: Identifiable, Codable {
    let id = UUID()
    let title: String
    let author: String
    let numComments: Int
    let thumbnail: String
    let createdUtc: Double
    var readed: Bool? = false
}
