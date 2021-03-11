//
//  ViewController.swift
//  PhotoFlicker
//
//  Created by Mohamed on 3/11/21.
//

import UIKit

class ViewResultVc: UIViewController {

    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var SearchBar: UISearchBar! {
    didSet{
        SearchBar.becomeFirstResponder()
    }
}
    
private let refreshControl = UIRefreshControl()


//MARK:Propertied
var photoModel:PhotosModal!
var searchPhotos = [Photo]()
var pageCount = 1
var searching = false
let DataSearch:[String] = ["mountain","moon","cairo"]


override func viewDidLoad() {
    super.viewDidLoad()
    getPhoto(tag:DataSearch.randomElement())
    setupUI()
}
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true

}

func setupUI() {
    setupCollectionView()
    setupSearchBar()
    refreshForPagination()
    navigationController?.isNavigationBarHidden = true
}


func refreshForPagination() {
    refreshControl.tintColor = .black
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    photoCollectionView.addSubview(refreshControl)
    photoCollectionView.alwaysBounceVertical = true
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to see more")
}

func getPhoto(tag:String? = nil , page:String? = nil) {
    let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=c7c721d8a8bec200aaa94ebeb3917225&tags=\(tag ?? "")&format=json&extras=url_m&nojsoncallback=1&per_page=15&page=\(page ?? "")&pages=20"
    ApiService.Shared.fetchData(url: url, parms: nil, headers: nil, method: .get) {[weak self] (getData:PhotosModal?, failData:PhotosModal?, error) in
        guard let self = self else {return}
        if let error = error {
            
            print(error.localizedDescription)
            Alert.showBasicAlert(on: self, with: "Error", message: error.localizedDescription)
            self.refreshControl.endRefreshing()
        }
        else {
            DispatchQueue.main.async {
                self.photoModel = getData
                self.refreshControl.endRefreshing()
                self.photoCollectionView.reloadData()
            }
        }
    }
}

@objc func refreshData() {
    pageCount+=1
    let DataSearch:[String] = ["mountain","moon","cairo"]
    if SearchBar.text?.isEmpty == true {
        getPhoto(tag:DataSearch.randomElement(), page: pageCount.description)
        photoCollectionView.reloadData()
    }
    else {
        getPhoto(tag:SearchBar.text, page: pageCount.description)
        photoCollectionView.reloadData()
    }
}



}
extension ViewResultVc : UISearchBarDelegate {

func setupSearchBar() {
    SearchBar.delegate = self
}
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    if let text = searchBar.text {
        searchPhotos = []
        photoCollectionView.reloadData()
        getPhoto(tag: text)
    }
}
func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = ""
    refreshData()

}

func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty == false {
        pageCount+=1
        let data = photoModel.photos?.photo ?? []
        searchPhotos = data.filter({ ($0.title?.contains(searchText) ?? (0 != 0)) })
        getPhoto(tag: searchText, page: pageCount.description)
      }

      photoCollectionView.reloadData()

}


}
