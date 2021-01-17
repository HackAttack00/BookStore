//
//  BooksListViewModel.swift
//  BookStore
//
//  Created by seungchul lee on 2021/01/14.
//

import Foundation

class BooksListViewModel: Codable {
    var error: String
    var total: String
    var books: [BookViewModel]
    
    init() {
        self.error = ""
        self.total = ""
        self.books = [BookViewModel]()
    }
}

struct BookViewModel: Codable {
    let bookModel: BookModel
}

extension BookViewModel {
    var title: String { self.bookModel.title }
    var subtitle: String { self.bookModel.subtitle }
    var isbn13: String { self.bookModel.isbn13 }
    var price: String { self.bookModel.price }
    var image: String { self.bookModel.image }
    var url: String { self.bookModel.url }
}




class BookDetailInfoListViewModel: Codable {
    var books: [BookDetailInfoViewModel]
    
    init() {
        self.books = [BookDetailInfoViewModel]()
    }
}

struct BookDetailInfoViewModel: Codable {
    let bookDetailInfoModel: BookDetailInfoModel
}

extension BookDetailInfoViewModel {
    var error: String { self.bookDetailInfoModel.error }
    var title: String { self.bookDetailInfoModel.title }
    var subtitle: String { self.bookDetailInfoModel.subtitle }
    var authors: String { self.bookDetailInfoModel.authors }
    var publisher: String { self.bookDetailInfoModel.publisher }
    var isbn10: String { self.bookDetailInfoModel.isbn10 }
    var isbn13: String { self.bookDetailInfoModel.isbn13 }
    var pages: String { self.bookDetailInfoModel.pages }
    var year: String { self.bookDetailInfoModel.year }
    var rating: String { self.bookDetailInfoModel.rating }
    var desc: String { self.bookDetailInfoModel.desc }
    var price: String { self.bookDetailInfoModel.price }
    var image: String { self.bookDetailInfoModel.image }
    var url: String { self.bookDetailInfoModel.url }
}
