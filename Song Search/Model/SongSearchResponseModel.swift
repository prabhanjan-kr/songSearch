//
//  SongSearchResultModel.swift
//  Song Search
//
//  Created by prabhanjan on 04/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//

import Foundation

struct SongSearchResponseModel : Codable {
    
    let resultCount : Int?
    let results : [SongSearchResult]?
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decodeIfPresent(Int.self, forKey: .resultCount)
        results = try values.decodeIfPresent([SongSearchResult].self, forKey: .results)
    }
    
}
