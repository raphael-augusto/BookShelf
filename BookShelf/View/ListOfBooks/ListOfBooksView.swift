//
//  ListOfBooksView.swift
//  BookShelf
//
//  Created by Raphael Augusto on 18/03/23.
//

import Foundation

import UIKit

//protocol ListOfBooksDelegate: AnyObject {
//    func <#actionButton#> ()
//}


final class ListOfBooksView: UIView {
    
    //MARK: - Delegate
    
    //MARK: - Properts
    
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

//MARK: - Components and Constraints
extension ListOfBooksView : ConfigurableView {
    func initView() {
        backgroundColor = .red
    }
    
    func initSubviews() {
        
    }
    
    func initConstraints() {
        
    }
    
    
}


//MARK: - Action
//extension ListOfBooksView: ListOfBooksDelegate {
//
//}

