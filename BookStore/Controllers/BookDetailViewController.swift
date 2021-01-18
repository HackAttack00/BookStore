//
//  BookDetailViewController.swift
//  BookStore
//
//  Created by seungchul lee on 2021/01/17.
//

import Foundation
import UIKit

protocol BookFocusingProtocol {
    typealias SetFocusedBookIndex = (Int) -> Void
}

class BookDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, BookFocusingProtocol{
    var booksListData = sharedDataSource.sharedInstance
    
    var bookDetailInfoListViewModel = BookDetailInfoListViewModel()
    var searchString: String?
    var currentIndex: String?
    
    var setFocusedBookIndex: SetFocusedBookIndex? // 선택한 버튼의 타이틀 값 closer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = .green
        self.collectionView?.isPagingEnabled = true
        self.collectionView?.register(BookDetailCell.self, forCellWithReuseIdentifier: "BookDetailCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let currentIndex = self.currentIndex {
            let indexPath = IndexPath(row: Int(currentIndex) ?? 0, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    private func requestBooksList(isbn13:String, completion: @escaping (BookDetailInfoModel)->()) {
        let isbn13 = isbn13
        guard let bookDetailInfoURL = URL(string: "https://api.itbook.store/1.0/books/\(isbn13)") else {
            fatalError("URL is incorrect!")
        }

        Webservice().load(resource:Resource<BookDetailInfoModel>(url:bookDetailInfoURL)) { result in
            switch result {
            case .success(let bookDetailInfo):
                print(bookDetailInfo)
                let bookInfo = BookDetailInfoViewModel(bookDetailInfoModel: bookDetailInfo)
                self.bookDetailInfoListViewModel.books.append(bookInfo)
                DispatchQueue.main.async {
                    completion(bookDetailInfo)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksListData.booksListViewModel.books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailCell", for: indexPath) as! BookDetailCell
        cell.backgroundColor = .blue
        let vm = booksListData.booksListViewModel.books[indexPath.row]
        requestBooksList(isbn13: vm.isbn13) { (bookDetailInfoModel) in
            cell.bookTitle.text = bookDetailInfoModel.title
            cell.bookDesc.text = bookDetailInfoModel.desc
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.setFocusedBookIndex!(indexPath.row)
    }
}
