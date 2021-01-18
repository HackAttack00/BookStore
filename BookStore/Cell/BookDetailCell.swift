//
//  BookDetailCell.swift
//  BookStore
//
//  Created by seungchul lee on 2021/01/17.
//

import Foundation
import UIKit

class BookDetailCell: UICollectionViewCell {
    let bookImageView: UIImageView = UIImageView()
    let bookTitle: UILabel = UILabel()
    let bookDesc: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bookImageView.backgroundColor = UIColor.brown
        
        bookTitle.textAlignment = .left
        bookTitle.numberOfLines = 0
        bookTitle.lineBreakMode = .byWordWrapping
        bookTitle.backgroundColor = UIColor.green
        
        bookDesc.textAlignment = .left
        bookDesc.numberOfLines = 0
        bookDesc.lineBreakMode = .byWordWrapping
        bookDesc.backgroundColor = UIColor.yellow

        contentView.backgroundColor = UIColor.white
        contentView.addSubview(bookImageView)
        contentView.addSubview(bookTitle)
        contentView.addSubview(bookDesc)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        bookDesc.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bookImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            bookImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            bookImageView.heightAnchor.constraint(equalToConstant: 300)
            ])
        
        NSLayoutConstraint.activate([
            bookTitle.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 10),
            bookTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bookTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bookTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 10)
            ])
        
        NSLayoutConstraint.activate([
            bookDesc.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 10),
            bookDesc.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            bookDesc.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            bookDesc.heightAnchor.constraint(greaterThanOrEqualToConstant: 10)
            ])
        
    }
}
