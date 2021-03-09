//
//  ProductListTableViewController.swift
//  MercadoLivre-Teste
//
//  Created by Pedro Lopes on 09/03/21.
//  Copyright © 2021 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class ProductListTableViewController: UITableViewController {
    
    private var productList: [SearchResult] = []
    private var pages: Int = 0
    private var searchTerm: String = ""
    
    private let network: SearchNetwork = SearchNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Resultados"
    }
    public func setupList(with list: [SearchResult],
                          term: String) {
        self.productList = list
        self.searchTerm = term
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductTableViewCell
        cell.product = self.productList[indexPath.row]
        cell.setup()
        cell.selectionStyle = .none
        
        self.getCellImage(for: self.productList[indexPath.row], cell: cell)
        
        return cell
    }
    
    private func getCellImage(for product: SearchResult, cell: ProductTableViewCell) {
        self.network.requestItemImage(from: product.thumbnail,
                                      callback: { image in
                                        
                                        if image != nil {
                                            cell.itemIcon.image = image
                                        }
        })
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productModal: ProductDetailsView = UIView.fromNib()

        productModal.layer.cornerRadius = 10.0
        productModal.setup(with: self.productList[indexPath.row])

        self.view.addSubview(productModal)
        
        productModal.translatesAutoresizingMaskIntoConstraints = false
              
        NSLayoutConstraint.activate([
            productModal.heightAnchor.constraint(equalToConstant: 400.00),
            productModal.widthAnchor.constraint(equalToConstant: self.view.frame.width - 20),
            productModal.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            productModal.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
              
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.productList.count {
            self.pages += 1
            self.network.search(term: self.searchTerm,
                                page: self.pages,
                                successCallback: {list in
                                    self.productList.append(contentsOf: list)
                                    self.tableView.reloadData()
                                }, errorCallback: { errorMessage in
                                    print(errorMessage)
                                    //Estudar casos de erro, não exibindo erro para o usuário caso seja apenas fim da lista.
                                })
        }
    }

}
