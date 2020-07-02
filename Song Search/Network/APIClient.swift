//
//  APIClient.swift
//  Song Search
//
//  Created by prabhanjan on 05/06/20.
//  Copyright © 2020 manorishi. All rights reserved.
//

import Alamofire
import RxSwift
//import SDWebImage


class APIClient {
    @discardableResult
    private static func performRequest<responseMappedObject:Decodable>(route:APIRouter) -> Observable<responseMappedObject> {
        return Observable.create { (observer) -> Disposable in
            let requestCall = Alamofire.request(route)
            requestCall.validate().decodable(success: { (mappedResponse:responseMappedObject) in
                observer.onNext(mappedResponse)
                observer.onCompleted()
            }, failure: { (error) in
                observer.onError(error)
                observer.onCompleted()
            })
            return Disposables.create {
                requestCall.cancel()
            }
            }
        
        // retry when API fails to particular error like Auth or something
//            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
//            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
//            .retryWhen({ (error:Observable<APIClientError>) in
//                error.flatMap{ error -> Observable<()?> in
//                    switch error {
        
//                    default:
//                        throw error
//                    }
//                    }.ignoreNil()
//            })
    }
    
    
    static func searchSongs(query : String) -> Observable<SongSearchResponseModel> {
        return performRequest(route: APIRouter.searchSong(query: query))
    }
    
}
