//
//  BooksListViewModel.swift
//  BookStore
//
//  Created by seungchul lee on 2021/01/14.
//

import Foundation

class BooksListViewModel:Codable {
    var error: String
    var total: String
    var books: [BookViewModel]
    
    init() {
        self.error = ""
        self.total = ""
        self.books = [BookViewModel]()
    }
}

struct BookViewModel:Codable {
    let bookModel: BookModel
}

extension BookViewModel {
    var title: String {
        self.bookModel.title
    }
    var subtitle: String {
        self.bookModel.subtitle
    }
    var isbn13: String {
        self.bookModel.isbn13
    }
    var price: String {
        self.bookModel.price
    }
    var image: String {
        self.bookModel.image
    }
    var url: String {
        self.bookModel.url
    }

}
