//
//  NewsVC.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import UIKit
import ProgressHUD
class NewsVC: UIViewController {
    @IBOutlet weak var newsTableView : UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var sources = [Source]()
    var articles = [Article]()
    var filteredArtcicles = [Article]()
    let customDatasource = NewsViewModel()
    var category = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Customize Navigation Bar
        navigationController?.navigationBar.barTintColor = Config.sharedManager.mainColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        //set up search bar
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["General","Business", "Technology" ,"Entertainment" ,"Science", "Sports"]
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Articles"
        searchController.searchBar.barTintColor = Config.sharedManager.mainColor
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        // Do any additional setup after loading the view.
        newsTableView.delegate = self
        newsTableView.dataSource = self
//        categoryCollectionView.delegate = self
//        categoryCollectionView.dataSource = self
        customDatasource.newsdelegate = self
        //customDatasource.sourcesdelegate = self
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        
        
        //get Data from api
        getALLNewsData()
        getSourcesData()
        
       
        
    }
    

}

extension NewsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell{
           
                cell.configureCellWith(source: sources[indexPath.item])
            cell.delegate = self
            cell.indexPath = indexPath
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension NewsVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredArtcicles.count
        }
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell{
            if isFiltering() {
                cell.configureCellWith(article: filteredArtcicles[indexPath.item])
            }else{
            cell.configureCellWith(article: articles[indexPath.item])
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var article : Article?
        if isFiltering() {
            article = filteredArtcicles[indexPath.item]
        }else{
           article = articles[indexPath.item]
        }
       
         let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetails") as! NewsDetailsVC
        detailsVC.articleName = article!.title
        detailsVC.author = article!.author!
        detailsVC.image_url = article!.urlToImage!
        detailsVC.date = article!.publishedAt!
        detailsVC.desc = "\(article!.description!)\n\(String(describing: article!.content)) "
        Switcher.navigateWithNavigationController(viewController: detailsVC)
    }
    
    
}
extension NewsVC: NewsDelegate{
    func didRecieveResponse(response: [Article]) {
         ProgressHUD.dismiss()
        self.articles.removeAll()
        self.articles = response
        newsTableView.reloadData()
    }
    
    func didFailDataUpdateWithError(error: String) {
         ProgressHUD.dismiss()
        _ = SweetAlert().showAlert("Error!", subTitle: error,  style: AlertStyle.error, buttonTitle:"Ok",
                                   buttonColor:UIColor.red)
    }
    
    
}

extension NewsVC:SourcesDelegate{
    func didRecieveSourceResponse(response: [Source]) {
        ProgressHUD.dismiss()
        self.sources = response
        //categoryCollectionView.reloadData()
    }
    
    func didFailUpdateWithError(error: String) {
         ProgressHUD.dismiss()
        _ = SweetAlert().showAlert("Error!", subTitle: error,  style: AlertStyle.error, buttonTitle:"Ok",
                                   buttonColor:UIColor.red)
    }
    
    
}
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
// MARK : searchview delegate
extension NewsVC : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
}

extension NewsVC : UISearchBarDelegate{
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension NewsVC : CategoryDelegate{
    func categoryClicked(indexPath: IndexPath) {
        let source = sources[indexPath.item]
        category = source.category
        ProgressHUD.show()
        getALLNewsData()
    }
    
    
}
// Mark Controller  Custom functions
extension NewsVC{
    func getSourcesData(){
        ProgressHUD.show()
        customDatasource.getSources(type: "sources",category: category)
    }
    
    func getALLNewsData(){
        
        customDatasource.getArticles(type: "top-headlines",category: category)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredArtcicles = articles.filter({( article : Article) -> Bool in
            return article.title.lowercased().contains(searchText.lowercased())
        })
        
        newsTableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    @objc func refresh() {
        ProgressHUD.show()
         getALLNewsData()
    }
}

