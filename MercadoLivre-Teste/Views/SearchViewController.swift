//
//  SearchViewController.swift
//  MercadoLivre-Teste
//
//  Created by Pedro Lopes on 08/03/21.
//  Copyright © 2021 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchLoadingLockView: UIView!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    
    private let network: SearchNetwork = SearchNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchField.returnKeyType = .search
        self.searchField.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchLock(false)
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func searchLock(_ lock: Bool = true) {
        
        if lock {
            self.searchLoadingLockView.isHidden = false
            self.searchActivityIndicator.isHidden = false
            self.searchActivityIndicator.startAnimating()
        } else {
            self.searchLoadingLockView.isHidden = true
            self.searchActivityIndicator.isHidden = true
            self.searchActivityIndicator.stopAnimating()
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.searchField {
            self.searchField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {

        if let searchTerm = textField.text {
            self.searchLock()
            self.network.search(term: searchTerm,
                                successCallback: { list in
                                    
                                    if let listVC = UIStoryboard.init(name: "Main",
                                                                      bundle: Bundle.main)
                                        .instantiateViewController(withIdentifier: "ProductListVC") as? ProductListTableViewController {
                                     
                                        listVC.setupList(with: list, term: searchTerm)
                                        self.navigationController?.pushViewController(listVC, animated: true)
                                    }

                                    
            },
                                errorCallback: { errorMessage in
                                    print(errorMessage)
                                    
                                    let errorView: ErrorView = UIView.fromNib()
                                    errorView.setup(with: errorMessage, callback: {
                                        self.searchLock(false)
                                    })
                                    
                                    self.view.addSubview(errorView)
                                    
                                    errorView.translatesAutoresizingMaskIntoConstraints = false
                                                
                                          NSLayoutConstraint.activate([
                                              errorView.heightAnchor.constraint(equalToConstant: 600.00),
                                              errorView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 20),
                                              errorView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                              errorView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
                                          ])
            })
        }
    }
}
