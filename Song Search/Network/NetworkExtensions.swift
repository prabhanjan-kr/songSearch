//
//  NetworkExtensions.swift
//  Song Search
//
//  Created by prabhanjan on 05/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//  making some changes to test a sample pull request

import Alamofire

extension Alamofire.DataRequest {
    
    @discardableResult
    func decodable<T: Decodable>(success: @escaping (T) -> Swift.Void, failure: @escaping (APIClientError) -> Swift.Void) -> Self {
        response(completionHandler: { response in
            /*TODO: Inculde where clause*/
            guard response.error == nil else {
                if let error = response.error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
//                    Can put a banner accross the app saying offline
                    failure(APIClientError.Offline)
                    return
                }
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                        default:
                        break
                    }
                }
                failure (APIClientError.error(response.error!))
                return
            }
            
            if let statusCode = response.response?.statusCode, statusCode == 204 {
                failure (APIClientError.NoContent)
                return
            }
            
            if let data = response.data {
                
                //                do {
                //                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                //                    print(json)
                //                } catch let error as NSError {
                //                    print(error)
                //                }
                
                guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                    failure(APIClientError.CouldNotDecodeJSON)
                    return
                }
                success(result)
                // print(result)
            }
        })
        return self
    }
}
