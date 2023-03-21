//
//  ListOfBooksView.swift
//  BookShelf
//
//  Created by Raphael Augusto on 18/03/23.
//

import UIKit


final class ListOfBooksView: UIView {
    
    //MARK: - Delegate
    let collection = CollectionViewTableViewCell()
    
    
    //MARK: - Properts
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        return tableView
    }()
    
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        initLayout()
    }
}

//MARK: - func configurable
extension ListOfBooksView {
    
    public func loadResultTableView() {
        self.tableView.reloadData()
    }
    
    
    //tableView
    public func tableViewDelegateDataSource(tableViewDelegate: UITableViewDelegate, tableViewDataSource: UITableViewDataSource) {
        self.tableView.delegate    = tableViewDelegate
        self.tableView.dataSource  = tableViewDataSource
    }
    
    
    //collectionView Cell
    public func collectionView(collectionViewDelegate: UICollectionViewDelegate, collectionViewDataSource: UICollectionViewDataSource) {
        collection.collectionViewDelegateDataSource(collectionViewDelegate: collectionViewDelegate, collectionViewDataSource: collectionViewDataSource)
    }
}


//MARK: - Components and Constraints
extension ListOfBooksView : ConfigurableView {
    func initView() {
        backgroundColor = .systemBackground
    }
    
    func initSubviews() {
        addSubview(tableView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
