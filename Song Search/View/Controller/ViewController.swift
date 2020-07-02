//
//  ViewController.swift
//  Song Search
//
//  Created by prabhanjan on 04/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//

import UIKit
import Foundation
import RxCocoa
import RxSwift
import SVProgressHUD
import SDWebImage

class ViewController: UIViewController {
    
    // MARK: Outlets and properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var songListTableView: UITableView!
    
    var trackListData : SongSearchResponseModel? {
        didSet {
            self.songListTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.songListTableView.delegate = self
        self.songListTableView.dataSource = self
        self.searchBar.delegate = self
        searchBar.becomeFirstResponder()
        self.title = "Song Search"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


// MARK: Tableview delegates
extension ViewController :UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var numOfSections: Int = 0
        if (self.trackListData?.resultCount ?? 0) > 0
        {
            songListTableView.separatorStyle = .singleLine
            numOfSections            = 1
            songListTableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: songListTableView.bounds.size.width, height: songListTableView.bounds.size.height))
            noDataLabel.text          = "No data"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            songListTableView.backgroundView  = noDataLabel
            songListTableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trackListData?.resultCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = songListTableView.dequeueReusableCell(withIdentifier: "songListCell") as! SongListTableViewCell
        // row data preparation
        let currentRowData = self.trackListData?.results?[indexPath.row]
        cell.setCelldata(songData: currentRowData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.resignFirstResponder()
        //go to next VC with corresponding object at indexpath.row
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "songDetailsViewController") as! SongDetailsViewController
        nextVC.detailsData = self.trackListData?.results?[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
// MARK: Searchbar delegates
extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //URL percent encoding for search query
        let escapedString = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        makeSearchRequest(query: escapedString ?? "")
    }
}

// MARK: API calls
extension ViewController {
    func makeSearchRequest(query : String) {
        SVProgressHUD.show(withStatus: "Loading")
        let searchAPI = APIClient.searchSongs(query: query)
        searchAPI.observeOn(MainScheduler.instance).subscribe(onNext: {[weak self] (response) in
            //            print(response.results)
            DispatchQueue.main.async {
                self?.trackListData = response
                SVProgressHUD.dismiss()
                self?.searchBar.resignFirstResponder()
            }
            
            }, onError: { (error) in
                //can write a generic method for Alerts across projects via BaseViewController
                SVProgressHUD.dismiss()
                //alert
                let alertController = UIAlertController(title: "Error", message: "Oops! Something went wrong.\nPlease try again", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
                    print("You've pressed cancel")
                }
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
        }, onCompleted: {
            // do needfull
        }) {
            //dispose
            
        }
        
    }
}


