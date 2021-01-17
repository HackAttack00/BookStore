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

/*
 "error": "0"
 "title": "Securing DevOps"
 "subtitle": "Security in the Cloud"
 "authors": "Julien Vehent"
 "publisher": "Manning"
 "isbn10": "1617294136"
 "isbn13": "9781617294136"
 "pages": "384"
 "year": "2018"
 "rating": "5"
 "desc": "An application running in the cloud can benefit from incredible efficiencies, but they come with unique security threats too. A DevOps team's highest priority is understanding those risks and hardening the system against them.Securing DevOps teaches you the essential techniques to secure your cloud ..."
 "price": "$26.98"
 "image": "https://itbook.store/img/books/9781617294136.png"
 "url": "https://itbook.store/books/9781617294136"
 "pdf": {
           "Chapter 2": "https://itbook.store/files/9781617294136/chapter2.pdf",
           "Chapter 5": "https://itbook.store/files/9781617294136/chapter5.pdf"
        }
 */

struct BookDetailInfoModel: Codable {
    var error: String
    var title: String
    var subtitle: String
    var authors: String
    var publisher: String
    var isbn10: String
    var isbn13: String
    var pages: String
    var year: String
    var rating: String
    var desc: String
    var price: String
    var image: String
    var url: String
}

