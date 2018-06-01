//
//  MovieFinderVC.swift
//  MovieFinder-Swift
//
//  Created by sarath on 17/05/18.
//  Copyright © 2018 com.sarath.homeProduction. All rights reserved.
//

import UIKit

class MovieFinderVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var activityIndicator = UIActivityIndicatorView()
    var isSearching:Bool = false
    var recentSearchArray:[String]?
    
    private let jsonData = NetworkManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = UIReturnKeyType.search
        tableView.register(UINib(nibName: "ResultViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "RecentSearchCell", bundle: nil), forCellReuseIdentifier: "recentCell")
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension MovieFinderVC:UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching == false{
         return 1
        }else{
        return 2
        }
    }
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     
        switch section {
        case 0:
            return "Recent History"
        case 1:
            return "Search Result"
        default:
            return ""
            
        }
        
        
    }
}
extension MovieFinderVC:UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            if let array = recentSearchArray{
                return array.count
            }else{
                return 0
            }
        case 1:
            return 6
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recentSearchCell = tableView.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath) as! RecentSearchCell
        let cell             = tableView.dequeueReusableCell(withIdentifier:"Cell" , for: indexPath) as! ResultViewCell

        recentSearchCell.titleLabel?.text = recentSearchArray?[indexPath.row]
        if isSearching{
                if indexPath.section == 0 {
                    return recentSearchCell
                }
                else {
                    
                    cell.movieName?.text = "titanic"
                    return cell
                    
                }
            }
            
        else{
           
           return recentSearchCell
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! ResultViewCell
        searchBar.text = currentCell.movieName?.text
        searchBar.becomeFirstResponder()
    }
    
    
}
extension MovieFinderVC:UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.becomeFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true
            recentSearchArray?.append(searchBar.text!)
            jsonData.requestData(searchElement: searchBar.text!)
            searchBar.resignFirstResponder()
            tableView.addSubview(activityIndicator)
            activityIndicator.center = tableView.center
            activityIndicator.backgroundColor = .red
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
            activityIndicator.frame = CGRect(x:0, y: 0, width: 46, height: 46)
            activityIndicator.startAnimating()
            tableView.reloadData()

            
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    
}

