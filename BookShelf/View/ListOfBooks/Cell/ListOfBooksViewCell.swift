//
//  ListOfBooksViewCell.swift
//  BookShelf
//
//  Created by Raphael Augusto on 19/03/23.
//

import UIKit


final class ListOfBooksViewCell: UICollectionViewCell {
    
    //MARK: - Delegate and indentifier
    static let indentifier = "ListOfBooksViewCell"
    
    //MARK: - Properts
    private lazy var posterView: UIView = {
        let label = UIView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        

        return label
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

//MARK: - Components and Constraints
extension ListOfBooksViewCell : ConfigurableView {
    func initView() {
        backgroundColor = .green
    }
    
    func initSubviews() {
        self.contentView.addSubview(posterView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            posterView.topAnchor.constraint(equalTo: topAnchor),
            posterView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            posterView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            posterView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    
}


