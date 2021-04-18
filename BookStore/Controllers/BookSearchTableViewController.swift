//
//  BookSearchTableViewController.swift
//  BookStore
//
//  Created by seungchul lee on 2021/01/25.
//

import Foundation
import UIKit

class BookSearchTableViewController: UITableViewController, UISearchBarDelegate {
    var booksListData = sharedDataSource.sharedInstance
    @IBOutlet var searchbar: UISearchBar!
    var searchText: String?
    var currentPage: Int = 0
    var isMoreLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
//        requestBooksList(search: "", page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func requestBooksList(search:String, page:Int) {
        guard let booksListURL = URL(string: "https://api.itbook.store/1.0/search/\(search)/\(page)") else {
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
//                    self.booksListData.append(booksList: booksListViewModel)
                    self.booksListData.append(searchedBooksList: booksListViewModel)
                }
                self.tableView.reloadData()
                self.isMoreLoading = true
            case .failure(let error):
                print(error)
                self.isMoreLoading = true
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.booksListViewModel.books.count
        return booksListData.booksSearchListViewModel.books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = booksListData.booksSearchListViewModel.books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksTableViewCell", for: indexPath) as! BookCell
//        cell.bookImageView.image = nil
//        cell.bookImageView.load(url: URL(string: vm.image)!, placeholder: nil, cache: nil)
        cell.titleLabel?.text = vm.title
        cell.subTitleLabel?.text = vm.subtitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! BookCell
        let vm = booksListData.booksSearchListViewModel.books[indexPath.row]
        cell.bookImageView.image = nil
        cell.bookImageView.load(url: URL(string: vm.image)!, placeholder: nil, cache: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.searchbar.resignFirstResponder()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let bookDetailViewController = BookDetailViewController(collectionViewLayout: layout)
        bookDetailViewController.booksListViewModel = sharedDataSource.sharedInstance.booksSearchListViewModel
        bookDetailViewController.currentIndex = indexPath.row
        weak var tableView = tableView
        bookDetailViewController.setFocusedBookIndex = { index in
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: index, section: 0)
                tableView?.scrollToRow(at: indexPath, at: .middle, animated: true)
            }
        }
        self.navigationController?.pushViewController(bookDetailViewController, animated: true)
    }
    
    @IBAction func pressedCloseBtn(btn: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchbar.resignFirstResponder()
        self.booksListData.removeSearchListAll()
        guard let searchBarText = searchBar.text else {
            return
        }
        searchText = searchBarText
        currentPage = 0
        self.requestBooksList(search: searchBarText, page: currentPage)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y
        
        if scrollPosition > 0 && scrollPosition < (scrollView.contentSize.height*0.2) && self.isMoreLoading {
            isMoreLoading = false
            
            if (self.booksListData.booksSearchListViewModel.books.count != Int(self.booksListData.booksSearchListViewModel.total)) {
                currentPage += 1
                guard let searchBarText = searchText else {
                    return
                }
                self.requestBooksList(search: searchBarText, page: currentPage)
            }
        }
    }
}
