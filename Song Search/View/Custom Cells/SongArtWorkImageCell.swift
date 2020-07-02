//
//  SongArtWorkImageCell.swift
//  Song Search
//
//  Created by prabhanjan on 08/06/20.
//  Copyright © 2020 manarorishi. All rights reserved.
//

import Foundation
import UIKit

class SongArtWorkImageCell: UITableViewCell {
    
    @IBOutlet weak var artWorkImageView: UIImageView!
    
    override func awakeFromNib() {
        //
    }
    
    func setImageData(imageData : SongSearchResult?) {
        let placeHolder = UIImage(named: "vinyl")
        self.artWorkImageView.sd_setImage(with: URL(string: imageData?.artworkUrl100 ?? ""), placeholderImage: placeHolder)
    }
    
}
