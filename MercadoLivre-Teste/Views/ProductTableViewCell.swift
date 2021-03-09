//
//  ProductTableViewCell.swift
//  MercadoLivre-Teste
//
//  Created by Pedro Lopes on 09/03/21.
//  Copyright © 2021 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var qualityLabel: UILabel!
    @IBOutlet weak var itemIcon: UIImageView!
    
    var product: SearchResult?
    
    func setup() {
        
        if let _ = self.product {
            self.titleLabel.text = self.product!.title
            self.priceLabel.text = self.formatPrice(self.product!.price)
            self.qualityLabel.text = self.product!.condition
        }
    }
    
    func formatPrice(_ price: Double) -> String {
        
        let newPrice = price/100
        let formattedPrice: String = String(format: "%.2f", newPrice)
        
        return "R$ \(formattedPrice)"

    }
}
