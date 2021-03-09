//
//  SearchNetwork.swift
//  MercadoLivre-Teste
//
//  Created by Pedro Lopes on 08/03/21.
//  Copyright © 2021 Pedro Lopes. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class SearchNetwork {
    
    private let requestBase = Constants.baseURL + Constants.searchURL
    
    public func search(term: String,
                       page: Int = 0,
                       successCallback: @escaping ([SearchResult]) -> Void,
                       errorCallback: @escaping (String) -> Void)  {
        
        let treatedTerm = term.replacingOccurrences(of: " ", with: "%20")
        AF.request(requestBase + treatedTerm, parameters: ["offset": page*50])
          .responseDecodable(of: SearchResponse.self) { (result) in
            
            switch result.result {
                case .success(let searchResultList):
                    let resultList = searchResultList.searchResults
                    successCallback(resultList)
                
                case .failure(let error):
                    print(error)
                    errorCallback(error.errorDescription ?? "Erro desconhecido")
            }
        }
    }
    
    public func requestItemImage(from url: String,
                                 callback: @escaping (UIImage?) -> Void) {
        AF.request(url).responseImage{ response in
            if let dataImg = response.data {
                let image = UIImage(data: dataImg, scale: 1.0)
                callback(image)
            } else {
                callback(nil)
            }
        }
    }
}
