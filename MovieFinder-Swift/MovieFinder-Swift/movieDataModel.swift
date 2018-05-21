//
//  movieDataModel.swift
//  MovieFinder-Swift
//
//  Created by sarath on 17/05/18.
//  Copyright © 2018 com.sarath.homeProduction. All rights reserved.
//

import UIKit

protocol movieDataModelDelegate: class {
    
    func  didReciveDataUpdate(parsedData:AnyClass)
    func  didFaileWithError(error:Error)
}

class movieDataModel: NSObject {
    
    weak var delegate: movieDataModelDelegate?
    
    func requestData() {
        
        //API call
        
      guard let url = URL(string: "http://www.omdbapi.com/?t=titanic") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error)
            in
            guard let data = data else {
                print("Error: No data to decode")
                return
            }
            
            guard let jsonResponse = try? JSONDecoder().decode(movie.self, from: data) else {
                print("Error: Couldn't decode data into Blog")
                return
            }
            print(jsonResponse.movie_char!)
        }
  
        task.resume()
    }
    func setDataToModelItem(response:[AnyObject]){
        
       // delegate?.didReciveDataUpdate(parsedData:AnyClass)
        
    }
}
