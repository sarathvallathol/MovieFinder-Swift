//
//  DetailedViewController.swift
//  MovieFinder-Swift
//
//  Created by sarath on 03/06/18.
//  Copyright © 2018 com.sarath.homeProduction. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var posterUIImage:UIImageView!
    @IBOutlet weak var movieName: UILabel!
    var posterImage:UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        posterUIImage.image = posterImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   @IBAction func back(sender: UIBarButtonItem) {
    // Perform your custom actions
    // ...
    // Go back to the previous ViewController
    _ = navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
