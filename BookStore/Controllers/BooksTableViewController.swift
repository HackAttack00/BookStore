//
//  BooksTableViewController.swift
//  BookStore
//
//  Created by seungchul lee on 2021/01/14.
//

import Foundation
import UIKit

class BooksTableViewController: UITableViewController {
    var booksListViewModel = BooksListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        requestBooksList()
    }
    
    private func requestBooksList() {
        guard let booksListURL = URL(string: "https://api.itbook.store/1.0/new") else {
            fatalError("URL is incorrect!")
        }

        Webservice().load(resource:Resource<BookListModel>(url:booksListURL)) { result in
            switch result {
            case .success(let booksList):
                print(booksList)
                if let books = booksList.books {
                    self.booksListViewModel.error = booksList.error
                    self.booksListViewModel.total = booksList.total
                    self.booksListViewModel.books = books.map(BookViewModel.init)
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.booksListViewModel.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.booksListViewModel.books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksTableViewCell", for: indexPath) as! BookCell
        cell.titleLabel?.text = vm.title
        cell.subTitleLabel?.text = vm.subtitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = self.booksListViewModel.books[indexPath.row]
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let bookDetailViewController = BookDetailViewController(collectionViewLayout: layout)
        bookDetailViewController.isbn13 = vm.isbn13
        self.navigationController?.pushViewController(bookDetailViewController, animated: true)
    }
}
