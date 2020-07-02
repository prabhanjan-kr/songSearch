//
//  SongDetailsViewController.swift
//  Song Search
//
//  Created by prabhanjan on 08/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//

import Foundation
import UIKit

class SongDetailsViewController: UIViewController {
    
    @IBOutlet weak var songDetailsTableView: UITableView!
    var detailsData : SongSearchResult?
    
    override func viewDidLoad() {
        //
        songDetailsTableView.delegate = self
        songDetailsTableView.dataSource = self
        songDetailsTableView.rowHeight = UITableViewAutomaticDimension
        songDetailsTableView.estimatedRowHeight = 200
        songDetailsTableView.reloadData()
    }
    
}

extension SongDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "More Info"
        }
        else if section == 2 {
            return "Price Info"
        }
        else if section == 3 {
            return "Website"
        }
        else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "songArtWorkImageCell") as! SongArtWorkImageCell
            cell.setImageData(imageData: self.detailsData)
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "songDetailsCell") as! SongDetailsCell
            cell.setCellData(detailsData: self.detailsData)
            return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "songPriceCell") as! SongPriceCell
            cell.setCellData(priceData: self.detailsData)
            return cell
        }
        else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "more by \(self.detailsData?.artistName ?? "")"
            cell.textLabel?.textColor = UIColor.blue
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            //go to WebView VC
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "webContentDisplayViewController") as! WebContentDisplayViewController
            nextVC.redirectionURL = self.detailsData?.artistViewUrl
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}
