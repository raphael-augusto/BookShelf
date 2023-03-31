//
//  ListOfBooksViewController.swift
//  BookShelf
//
//  Created by Raphael Augusto on 18/03/23.
//

import UIKit

final class ListOfBooksViewController: UIViewController, ListOfBooksViewOutput  {
    
    //MARK: - ViewModel
    private lazy var listOfBooksViewModel: ListOfBooksViewModelInput = {
        let vm = ListOfBooksViewModel()
        vm.delegate = self
        
        return vm
    }()

    
    //MARK: - Properts
    private lazy var listOfBooksView: ListOfBooksViewInput = {
        let view = ListOfBooksView(delegate: self)
        
        return view
    }()
    
    
    var titleBooks:String = ""
    
    //MARK: - Life cycle
    override func loadView() {
        self.view = listOfBooksView as? UIView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchForBooksData()
        didFinishSuccess()
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
            listOfBooksView.searchBarIsHidden(false)
        } else {
            listOfBooksView.searchBarIsHidden(true)
        }
    }

}

//MARK: - Request API
extension ListOfBooksViewController: ListOfBooksViewModelOutput {

    private func fetchForBooksData() {
        listOfBooksViewModel.fetchBooks()
    }
       
    func didFinishSuccess() {
        DispatchQueue.main.async { [self] in
            listOfBooksView.loadResultTableView()
        }
    }
    
    func didFinishFailure(message: String) {}
    
}


//MARK: - TableView
extension ListOfBooksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listOfBooksViewModel.getNumberOfSections()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfBooksViewModel.getNumberOfRowsInSection(section: section)
    }
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return listOfBooksViewModel.getTitleForHeaderInSection(section: section)
//
//    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)

        label.text = listOfBooksViewModel.getTitleForHeaderInSection(section: section)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .darkGray
        headerView.addSubview(label)
        

        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListOfBooksViewCell.identifier, for: indexPath) as? ListOfBooksViewCell else { return UITableViewCell() }
        
        
        cell.setupCell(cell: self.listOfBooksViewModel.getCellForRowAt(indexPath: indexPath))
        

        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Aqui você pode executar alguma ação ao selecionar um livro, por exemplo.
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}


extension ListOfBooksViewController: UISearchBarDelegate {
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Quando o texto da barra de pesquisa muda
        titleBooks = searchText
    

        listOfBooksView.loadResultTableView()
    }
}


