//
//  ResultTableViewCell.swift
//  MovieFinder-Swift
//
//  Created by sarath on 03/06/18.
//  Copyright © 2018 com.sarath.homeProduction. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieCover: UIImageView?
    @IBOutlet weak var movieName: UILabel?
    @IBOutlet weak var descriptionLabel:UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
