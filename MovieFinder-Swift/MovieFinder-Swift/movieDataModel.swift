//
//  movieDataModel.swift
//  MovieFinder-Swift
//
//  Created by sarath on 17/05/18.
//  Copyright © 2018 com.sarath.homeProduction. All rights reserved.
//

import UIKit

protocol movieDataModelDelegate: class {
    
    func  didReciveDataUpdate()
    func  didFaileWithError(error:Error)
}

class movieDataModel: NSObject {
    
    weak var delegate: movieDataModelDelegate?
    
    func requestData() {
        
        //API call
        
        let data:[AnyObject]? = nil
        let error:Error? = nil
        
        if let error = error {
            delegate?.didFaileWithError(error:error)
        }else if let data = data{
            setDataToModelItem(response:data)
        }
    }
    func setDataToModelItem(response:[AnyObject]){
        
    }
}
