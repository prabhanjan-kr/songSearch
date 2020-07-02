//
//  SongListTableViewCell.swift
//  Song Search
//
//  Created by prabhanjan on 04/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//

import Foundation
import UIKit
class SongListTableViewCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var artWorkImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var trackDurationLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    func setCelldata(songData : SongSearchResult?) {
        let currentTrackDuration = self.convertToMinutesAndSecondsFormatFrom(milliseconds: songData?.trackTimeMillis  ?? 0)
        let currentTrackCurrencySymbol = songData?.currency?.getCurrencySymbol() ?? ""
        
        // data supply, alternatively can write setDataMethod
        self.trackNameLabel.text = songData?.trackName ?? "-"
        self.artistNameLabel.text = songData?.artistName ?? "-"
        self.genreLabel.text = songData?.primaryGenreName ?? "-"
        self.trackDurationLabel.text = currentTrackDuration
        self.trackPriceLabel.text = currentTrackCurrencySymbol + String(songData?.trackPrice ?? 0.0)
        //lazy loading of artwork images
        self.artWorkImageView.sd_setImage(with: URL(string: songData?.artworkUrl60 ?? ""), placeholderImage: UIImage(named: "vinyl"))
        //
    }
    
    func convertToMinutesAndSecondsFormatFrom(milliseconds : Int) -> String {
        let inSeconds : Int = milliseconds / 1000
        let inMinutes : Int = inSeconds / 60
        let leftSeconds = inSeconds % 60
        return "\(inMinutes) :\(leftSeconds)"
    }
    
    
}
