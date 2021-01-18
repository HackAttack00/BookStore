//
//  DataSource.swift
//  BookStore
//
//  Created by seungchul lee on 2021/01/18.
//

import Foundation

class sharedDataSource : NSObject {
    static var sharedInstance = sharedDataSource();
    var booksListViewModel = BooksListViewModel()
    
    override init(){
        super.init()
    }
    
    func removeAll() {
        self.booksListViewModel.error = ""
        self.booksListViewModel.total = ""
        self.booksListViewModel.books.removeAll()
    }
    
    func append(book: BookViewModel) {
        self.booksListViewModel.books.append(book)
    }
    
    func append(booksList: BooksListViewModel) {
        self.booksListViewModel.books = booksList.books
    }
}
