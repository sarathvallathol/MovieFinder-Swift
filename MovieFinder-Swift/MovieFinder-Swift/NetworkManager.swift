//
//  movieDataModel.swift
//  MovieFinder-Swift
//
//  Created by sarath on 17/05/18.
//  Copyright © 2018 com.sarath.homeProduction. All rights reserved.
//

import UIKit

protocol movieDataModelDelegate: class {
    
    func  didReciveDataUpdate(parsedData:Movie)
    func  didFaileWithError(error:Error)
}

class NetworkManager: NSObject {
    
    private final let baseUrl = "http://www.omdbapi.com/?t="
    private final let apiKey  = "&apikey=653b3db5"
    
    weak var delegate: movieDataModelDelegate?
    
    func requestData(searchElement:String) {
        
      //API call
      guard let url = URL(string:baseUrl+searchElement+apiKey ) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error)
            in
            guard let data = data else{return}
            guard let jsonResponse = try? JSONDecoder().decode(Movie.self, from: data) else {
                print("Error: Couldn't decode data into Blog")
                return
            }
            self.updateResponse(response: jsonResponse)
        }
  
        task.resume()
    }
    func updateResponse(response:Movie){
        delegate?.didReciveDataUpdate(parsedData: response)
        
    }
    
}
