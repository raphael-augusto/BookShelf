//
//  ListOfBooksView.swift
//  BookShelf
//
//  Created by Raphael Augusto on 18/03/23.
//

import UIKit



protocol ListOfBooksViewOutput: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {}

protocol ListOfBooksViewInput {
    func loadResultTableView()
    func searchBarIsHidden(_ isHidden: Bool)
}

final class ListOfBooksView: UIView {
        
    //MARK: - Properts
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 70))
        searchBar.placeholder = "Search for book"
        searchBar.searchBarStyle = .minimal
        //searchBar.showsCancelButton = true
        
        return searchBar
    }()

    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListOfBooksViewCell.self, forCellReuseIdentifier: ListOfBooksViewCell.identifier)
        tableView.tableHeaderView = searchBar
        
        return tableView
    }()
    
    
    //MARK: - Inits
    init(delegate: ListOfBooksViewOutput) {
        super.init(frame: .zero)
        
        setup()
        
        tableView.dataSource = delegate
        tableView.delegate = delegate
        searchBar.delegate = delegate
    }
    
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


//MARK: - Functions configuration
extension ListOfBooksView: ListOfBooksViewInput {
    
    func loadResultTableView() {
        self.tableView.reloadData()
    }
    
    func searchBarIsHidden(_ isHidden: Bool) {
        searchBar.isHidden = isHidden
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


