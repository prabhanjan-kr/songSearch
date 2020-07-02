//
//  SongPriceCell.swift
//  Song Search
//
//  Created by prabhanjan on 08/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//

import Foundation
import UIKit

class SongPriceCell: UITableViewCell {
    
    
    @IBOutlet weak var songPriceLabel: UILabel!
    @IBOutlet weak var songRentalPriceLabel: UILabel!
    @IBOutlet weak var albumPriceLabel: UILabel!
    
    override func awakeFromNib() {
        //
    }
    
    func setCellData(priceData : SongSearchResult?) {
        let currentTrackCurrencySymbol = priceData?.currency?.getCurrencySymbol() ?? ""
        self.songPriceLabel.text = currentTrackCurrencySymbol + String(priceData?.trackPrice ?? 0.0)
        self.albumPriceLabel.text = currentTrackCurrencySymbol + String(priceData?.collectionPrice ?? 0.0)
        self.songRentalPriceLabel.text = currentTrackCurrencySymbol + String(priceData?.trackRentalPrice ?? 0.0)
    }
}
