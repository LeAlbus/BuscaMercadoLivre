//
//  ErrorView.swift
//  MercadoLivre-Teste
//
//  Created by Pedro Lopes on 09/03/21.
//  Copyright © 2021 Pedro Lopes. All rights reserved.
//

import Foundation
import UIKit

class ErrorView: UIView {
    
    @IBOutlet weak var errorLogLabel: UILabel!
    var closeCallback: () -> Void = {}
    
    @IBAction func closeAction(_ sender: Any) {
        self.closeCallback()
        self.removeFromSuperview()
    }
    
    public func setup(with message: String, callback: @escaping () -> Void) {
        self.errorLogLabel.text = message
        self.closeCallback = callback
    }
}
