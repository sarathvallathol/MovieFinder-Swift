//
//  ImageView+Extension.swift
//  MovieFinder-Swift
//
//  Created by sarath on 02/06/18.
//  Copyright © 2018 com.sarath.homeProduction. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
    func loadImageFromUrlString(urlString:String){
        
        let url = NSURL(string:urlString)
        let request = URLRequest(url:url! as URL)
        
        // If not, download image from url
        URLSession.shared.dataTask(with:request) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            guard let data = data else {return}
            DispatchQueue.main.async() {
                self.image = UIImage(data:data)
            }
            }.resume()
        
    }
}
    

