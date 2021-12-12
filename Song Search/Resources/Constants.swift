//
//  Constants.swift
//  Song Search
//
//  Created by prabhanjan on 05/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//  for third pull request adding test lines

import Foundation

struct K {
    
    struct Server {
        
        struct I_TunesSearchAPI {
            
            static let baseUrl = "https://itunes.apple.com/"
        }
    }
    
    static let fallBackRedirectionURL = "https://www.apple.com/apple-music/"
    
}

enum APIClientError: Error {
    case CouldNotDecodeJSON
    case NoContent
    case BadStatus(status: Int)
    case Offline
    case Other(String)
    case error(Error)
    case noError
}

enum ContentType: String {
    case json = "application/json"
    case text_html = "text/html"
    case text_javascript = "text/javascript"
    case formData = "application/x-www-form-urlencoded"
}
