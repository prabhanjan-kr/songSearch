//
//  APIRouter.swift
//  Song Search
//
//  Created by prabhanjan on 05/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case searchSong(query : String)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {

        case .searchSong:
            return .get

        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .searchSong(let query):
            return "/search?term=\(query)"

        }
    }
    
    // MARK: - Parameters
    private var parameters: Data? {
        switch self {

        case .searchSong:
            return nil
            
        }
    }
    
    private var contentType:String {
        switch self {
        default :
            return ContentType.json.rawValue
        }
    }
    
    private func convertTojsonData<T:Codable>(_ model:T) throws -> Data {
        return try JSONEncoder().encode(model)
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: K.Server.I_TunesSearchAPI.baseUrl)
        let appendingPath = self.path
        let urlWithPath = url.flatMap { URL(string: $0.absoluteString + appendingPath) }
        
        var urlRequest = URLRequest(url:urlWithPath!)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers or Headers specific to endpoints go here based on switch cases
        
        urlRequest.timeoutInterval = 90
        
        // Parameters
        urlRequest.httpBody = parameters
        if let hasParameters = parameters {
            do {
                let json = try JSONSerialization.jsonObject(with: hasParameters, options: .allowFragments)
                print(json)
            }
            catch{}
        }
        urlRequest.cachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
        
        return urlRequest
    }
}

