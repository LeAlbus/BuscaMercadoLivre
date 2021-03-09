//
//  ProductDetailsView.swift
//  MercadoLivre-Teste
//
//  Created by Pedro Lopes on 09/03/21.
//  Copyright © 2021 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailsView: UIView {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    private let network = SearchNetwork()
    private var url: String = ""
        
    public func setup(with product: SearchResult) {
        
        self.getItemImage(from: product.thumbnail)
        self.itemTitleLabel.text = product.title
        self.itemPriceLabel.text = "R$ \(String(format: "%.2f", product.price/100))"
        self.url = product.permalink
    }
    
    private func getItemImage(from url: String) {
        self.network.requestItemImage(from: url,
                                      callback: { image in
                                        
                                        if image != nil {
                                            self.itemImageView.image = image
                                        }
        })
    }
    
    @IBAction func visitPageAction(_ sender: Any) {
        if let itemLink = URL(string: self.url) {
            UIApplication.shared.open(itemLink)
        }
    }

    @IBAction func dismissAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}
