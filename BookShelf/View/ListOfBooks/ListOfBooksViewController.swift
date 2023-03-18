//
//  ListOfBooksViewController.swift
//  BookShelf
//
//  Created by Raphael Augusto on 18/03/23.
//

import UIKit

class ListOfBooksViewController: UIViewController {

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
    }

}

