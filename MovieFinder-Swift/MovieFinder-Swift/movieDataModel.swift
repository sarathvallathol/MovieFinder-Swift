//
//  movieDataModel.swift
//  MovieFinder-Swift
//
//  Created by sarath on 17/05/18.
//  Copyright © 2018 com.sarath.homeProduction. All rights reserved.
//

import UIKit

protocol movieDataModelDelegate {
    
    func  didReciveDataUpdate()
    func  didFaileWithError(erroR:Error)
}

class movieDataModel: NSObject {

}
