//
//  BookDetailViewController.swift
//  BookStore
//
//  Created by seungchul lee on 2021/01/17.
//

import Foundation
import UIKit

class BookDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var bookDetailInfoListViewModel = BookDetailInfoListViewModel()
    
    var isbn13: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = .green
        self.collectionView?.isPagingEnabled = true
        self.collectionView?.register(BookDetailCell.self, forCellWithReuseIdentifier: "BookDetailCell")
        
        self.requestBooksList()
    }
    
    private func requestBooksList() {
        let isbn13 = self.isbn13
        guard let bookDetailInfoURL = URL(string: "https://api.itbook.store/1.0/books/\(isbn13 ?? "")") else {
            fatalError("URL is incorrect!")
        }

        Webservice().load(resource:Resource<BookDetailInfoModel>(url:bookDetailInfoURL)) { result in
            switch result {
            case .success(let bookDetailInfo):
                print(bookDetailInfo)
                let bookInfo = BookDetailInfoViewModel(bookDetailInfoModel: bookDetailInfo)
                self.bookDetailInfoListViewModel.books.append(bookInfo)
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bookDetailInfoListViewModel.books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailCell", for: indexPath) as! BookDetailCell
        cell.backgroundColor = .red
//        cell = self.bookDetailInfoListViewModel.books[indexPath.row].title
        cell.bookTitle.text = self.bookDetailInfoListViewModel.books[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
