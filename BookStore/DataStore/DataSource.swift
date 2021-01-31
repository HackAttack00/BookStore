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
    var booksSearchListViewModel = BooksListViewModel()
    
    override init(){
        super.init()
    }
    
    func removeNewListAll() {
        self.booksListViewModel.error = ""
        self.booksListViewModel.total = ""
        self.booksListViewModel.books.removeAll()
    }
    
    func removeSearchListAll() {
        self.booksSearchListViewModel.error = ""
        self.booksSearchListViewModel.total = ""
        self.booksSearchListViewModel.books.removeAll()
    }
    
    func append(book: BookViewModel) {
        self.booksListViewModel.books.append(book)
    }
    
    func append(booksList: BooksListViewModel) {
        self.booksListViewModel.books.append(contentsOf: booksList.books)
    }
    
    func append(searchedBook: BookViewModel) {
        self.booksSearchListViewModel.books.append(searchedBook)
    }
    
    func append(searchedBooksList: BooksListViewModel) {
        self.booksSearchListViewModel.books.append(contentsOf: searchedBooksList.books)
    }
}
