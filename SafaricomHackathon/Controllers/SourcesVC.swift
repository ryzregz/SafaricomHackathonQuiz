//
//  SourceVC.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import UIKit
import ProgressHUD
class SourcesVC: UIViewController {
    @IBOutlet weak var sourceTableView : UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var sources = [Source]()
    var filteredSources = [Source]()
    let customDatasource = NewsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customize Navigation Bar
         navigationController?.navigationBar.barTintColor = Config.sharedManager.mainColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        // Do any additional setup after loading the view.
        sourceTableView.delegate = self
        sourceTableView.dataSource = self
        
        customDatasource.sourcesdelegate = self
        
        //set up search
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Sources"
        searchController.searchBar.barTintColor = Config.sharedManager.mainColor
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        ProgressHUD.show()
        customDatasource.getSources(type: "sources", category: "")
        
        
    }
 

}
// MARK : ViewController functions
extension SourcesVC {
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredSources = sources.filter({( source : Source) -> Bool in
            return source.name.lowercased().contains(searchText.lowercased())
        })
        
        sourceTableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

// MARK : searchview delegate
extension SourcesVC : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
}
}

extension SourcesVC:SourcesDelegate{
    func didRecieveSourceResponse(response: [Source]) {
        ProgressHUD.dismiss()
        self.sources = response
        sourceTableView.reloadData()
    }
    
    func didFailUpdateWithError(error: String) {
        ProgressHUD.dismiss()
        _ = SweetAlert().showAlert("Error!", subTitle: error,  style: AlertStyle.error, buttonTitle:"Ok",
                                   buttonColor:UIColor.red)
    }
    
    
}

extension SourcesVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredSources.count
        }
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as? SourceCell{
            if isFiltering() {
                cell.configureCellWith(source: filteredSources[indexPath.item])
            }else{
                cell.configureCellWith(source: sources[indexPath.item])
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.searchController.searchBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return searchController.searchBar.frame.height
    }
    
    
}
