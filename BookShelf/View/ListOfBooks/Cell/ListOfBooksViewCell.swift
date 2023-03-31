//
//  ListOfBooksViewCell.swift
//  BookShelf
//
//  Created by Raphael Augusto on 19/03/23.
//

import UIKit

protocol ListOfBooksViewCellInput {
    func setupCell(cell: BooksData?)
}

final class ListOfBooksViewCell: UITableViewCell {
    
    //MARK: - Identifier
    static let identifier:String = "ListOfBooksViewCell"

    
    //MARK: - Properts
    private lazy var imageURLView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 4
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    private lazy var nameTitle: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 19)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.tintColor = .white
        lb.numberOfLines = 2
        
        return lb
    }()
        
    private lazy var highlightLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.layer.cornerRadius = 3
        lb.clipsToBounds = true
        lb.textAlignment = .center
        
        return lb
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
}


//MARK: - functions configuration
extension ListOfBooksViewCell: ListOfBooksViewCellInput {
    
    public func setupCell(cell: BooksData?) {
        guard let url = URL(string: cell?.photo ?? "") else { return }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self.imageURLView.image = UIImage(data: data!)
            }
        }
        
        nameTitle.text = cell?.title
        highlightLabel.text = checkIsHighlight(check: (cell?.isHighlight ?? false))
        highlightLabel.backgroundColor = checkIsHighlightColor(check: (cell?.isHighlight ?? false))
    }
    
    
    private func checkIsHighlightColor(check: Bool) -> UIColor {
        return !check ? .clear : UIColor(red: 177/255, green: 202/255, blue: 169/255, alpha: 1)
    }
    
    
    private func checkIsHighlight(check: Bool) -> String{
        return !check ? "" : "Destaque"
    }
}


//MARK: - Components and Constraints
extension ListOfBooksViewCell : ConfigurableView {

    func initView() {
        backgroundColor = .none
    }
    
    func initSubviews() {
        addSubview(imageURLView)
        addSubview(nameTitle)
        addSubview(highlightLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            imageURLView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageURLView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageURLView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            imageURLView.heightAnchor.constraint(equalToConstant: 100),
            imageURLView.widthAnchor.constraint(equalToConstant: 200),
            
            nameTitle.leadingAnchor.constraint(equalTo: imageURLView.trailingAnchor, constant: 20),
            nameTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameTitle.topAnchor.constraint(equalTo: imageURLView.topAnchor),
            
            highlightLabel.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: 10),
            highlightLabel.leadingAnchor.constraint(equalTo: nameTitle.leadingAnchor),
            highlightLabel.widthAnchor.constraint(equalToConstant: 80),
            highlightLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
