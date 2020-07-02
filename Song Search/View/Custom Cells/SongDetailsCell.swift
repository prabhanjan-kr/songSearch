//
//  TrackDetailsCell.swift
//  Song Search
//
//  Created by prabhanjan on 08/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//

import Foundation
import UIKit

class SongDetailsCell: UITableViewCell {
    
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        //
    }
    
    func setCellData(detailsData : SongSearchResult?) {
        self.artistNameLabel.text = detailsData?.artistName ?? ""
        self.trackNameLabel.text = detailsData?.trackName ?? ""
        self.albumNameLabel.text = detailsData?.collectionName ?? ""
        self.releaseDateLabel.text = formatToReadableDate(date: detailsData?.releaseDate ?? "")
    }
    
    func formatToReadableDate(date : String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd yyyy"
        
        if let date2 = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date2)
        } else {
            return "Error"
        }
    }
    
}
