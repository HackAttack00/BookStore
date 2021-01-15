//
//  Book.swift
//  BookStore
//
//  Created by seungchul lee on 2021/01/14.
//

import Foundation

//https://api.itbook.store/1.0/new

/*
 title: "Learn Programming",
 subtitle: "Your Guided Tour Through the Programming Jungle",
 isbn13: "9781722834920",
 price: "$16.83",
 image: "https://itbook.store/img/books/9781722834920.png",
 url: "https://itbook.store/books/9781722834920"
 */

struct BookListModel: Codable {
    var error: String
    var total: String
    var books: [BookModel]?
}

struct BookModel: Codable {
    var title: String
    var subtitle: String
    var isbn13: String
    var price: String
    var image: String
    var url: String
}

