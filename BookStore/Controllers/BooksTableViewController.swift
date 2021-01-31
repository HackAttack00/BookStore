//
//  BooksTableViewController.swift
//  BookStore
//
//  Created by seungchul lee on 2021/01/14.
//

import Foundation
import UIKit

class BooksTableViewController: UITableViewController {
    var booksListData = sharedDataSource.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        requestBooksList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func requestBooksList() {
        guard let booksListURL = URL(string: "https://api.itbook.store/1.0/new") else {
            fatalError("URL is incorrect!")
        }

        Webservice().load(resource:Resource<BookListModel>(url:booksListURL)) { [self] result in
            switch result {
            case .success(let booksList):
                print(booksList)
                if let books = booksList.books {
                    let booksListViewModel = BooksListViewModel()
                    booksListViewModel.error = booksList.error
                    booksListViewModel.total = booksList.total
                    booksListViewModel.books = books.map(BookViewModel.init)
                    self.booksListData.append(booksList: booksListViewModel)
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
//        return self.booksListViewModel.books.count
        return booksListData.booksListViewModel.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = booksListData.booksListViewModel.books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksTableViewCell", for: indexPath) as! BookCell
        cell.titleLabel?.text = vm.title
        cell.subTitleLabel?.text = vm.subtitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let bookDetailViewController = BookDetailViewController(collectionViewLayout: layout)
        bookDetailViewController.booksListViewModel = sharedDataSource.sharedInstance.booksListViewModel
        bookDetailViewController.currentIndex = indexPath.row
        weak var tableView = tableView
        bookDetailViewController.setFocusedBookIndex = { index in
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: index, section: 0)
                tableView?.scrollToRow(at: indexPath, at: .middle, animated: false)
            }
        }
        self.navigationController?.pushViewController(bookDetailViewController, animated: true)
    }
}
