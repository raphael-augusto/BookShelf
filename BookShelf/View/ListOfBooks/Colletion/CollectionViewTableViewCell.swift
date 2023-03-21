//
//  CollectionViewTableViewCell.swift
//  BookShelf
//
//  Created by Raphael Augusto on 19/03/23.
//

import UIKit


final class CollectionViewTableViewCell: UITableViewCell {
    
    //MARK: - Identifier
    static let identifier = "CollectionViewTableViewCell"
    
    //MARK: - Properts
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ListOfBooksViewCell.self, forCellWithReuseIdentifier: ListOfBooksViewCell.indentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    
    
    //MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
       
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        initLayout()
    }
    
    
    public func collectionViewDelegateDataSource(collectionViewDelegate: UICollectionViewDelegate, collectionViewDataSource: UICollectionViewDataSource) {
        collectionView.delegate    = collectionViewDelegate
        collectionView.dataSource  = collectionViewDataSource
    }

}

//MARK: - Components and Constraints
extension CollectionViewTableViewCell : ConfigurableView {

    func initView() {
        backgroundColor = .red
    }
    
    func initSubviews() {
        self.contentView.addSubview(collectionView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -20),
            
        ])
    }
}


