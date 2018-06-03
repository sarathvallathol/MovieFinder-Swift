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
    var recentSearchArray:[String] = []
    var responseData:Movie?{
        didSet{
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    private let jsonData = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        tableView.addSubview(activityIndicator)
        self.searchBar.returnKeyType = UIReturnKeyType.search
        tableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            
            return 90
        }else{
            
            return 44
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
            return recentSearchArray.count
        case 1:
            return 1
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recentSearchCell = tableView.dequeueReusableCell(withIdentifier: "recentCell") as! RecentSearchCell
        let cell             = tableView.dequeueReusableCell(withIdentifier:"Cell") as! ResultTableViewCell
        
        if isSearching{
                if indexPath.section == 0 {
                    recentSearchCell.titleLabel?.text = recentSearchArray[indexPath.row]
                    return recentSearchCell
                }
                else {
                    
                    cell.movieName?.text = responseData?.movie_name
                    cell.descriptionLabel?.text = responseData?.movie_director
                    cell.movieCover?.loadImageFromUrlString(urlString:(responseData?.movie_coverUrl)!)
                    return cell
                    
                }
            }
            
        else{
           
           return recentSearchCell
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! ResultTableViewCell
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
             searchBar.resignFirstResponder()
            if recentSearchArray.contains(searchBar.text!){
                //Dont add to array
            }else{
                recentSearchArray.append(searchBar.text!)
            }
            let searchText = searchBar.text!
            activityIndicatorSetup()
            self.jsonData.requestData(searchElement:searchText, completion:{
                    (data) in
                    self.responseData = data
                    self.stopIndicator()
                })
        }
        
    }
    
    func activityIndicatorSetup(){
        activityIndicator.center = tableView.center
        activityIndicator.backgroundColor = .red
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x:0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
    }
    func stopIndicator(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()

        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    
}

