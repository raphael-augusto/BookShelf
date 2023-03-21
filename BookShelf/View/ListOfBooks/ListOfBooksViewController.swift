//
//  ListOfBooksViewController.swift
//  BookShelf
//
//  Created by Raphael Augusto on 18/03/23.
//

import UIKit

class ListOfBooksViewController: UIViewController {

    //MARK: - ViewModel
    private lazy var listOfBooksViewModel = ListOfBooksViewModel(delegate: self)
    
    
    //MARK: - Properts
    private lazy var listOfBooksView: ListOfBooksView = {
        let view = ListOfBooksView()
        
        return view
    }()
    
    
    //MARK: - Life cycle
    override func loadView() {
        self.view = listOfBooksView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateScreen()
        config()
        
        
    }
    
    private func config() {
        listOfBooksViewModel.getDataBooks()
    }
    
    private func delegateScreen() {
        listOfBooksView.tableViewDelegateDataSource(tableViewDelegate: self, tableViewDataSource: self)
        listOfBooksView.collectionView(collectionViewDelegate: self, collectionViewDataSource: self)
    }
}

//MARK: - Request API
extension ListOfBooksViewController: ListOfBooksViewModelDelegate {
    
    func didUpdateData() {

    }
    
    func didFinishSuccess() {
        DispatchQueue.main.async { [self] in
            listOfBooksView.loadResultTableView()
        }
    }
    
    func didFinishFailure() {
        print("ERROR -> ListOfBooksViewController")
    }
}


//MARK: - TableView
extension ListOfBooksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}


//MARK: - CollectionView
extension ListOfBooksViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListOfBooksViewCell.indentifier, for: indexPath) as? ListOfBooksViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .green
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: 100, height: 100)
//        }

    
}
