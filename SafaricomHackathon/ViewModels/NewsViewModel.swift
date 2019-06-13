//
//  NewsViewModel.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import Foundation
protocol NewsDelegate: class {
    func didRecieveResponse(response: [Article])
    func didFailDataUpdateWithError(error: String)
}

protocol SourcesDelegate: class {
    func didRecieveSourceResponse(response: [Source])
    func didFailUpdateWithError(error: String)
}
class NewsViewModel{
    let appServerClient = ApiServiceClient()
    var articles = [Article]()
    weak var newsdelegate: NewsDelegate?
     weak var sourcesdelegate: SourcesDelegate?

    func getArticles(type:String, category: String) {
        appServerClient.sendNewsRequest(type:type, category: category,onSuccess: {(res)
            in
            if let articles = res.articles{
                self.newsdelegate?.didRecieveResponse(response: articles)
            }else{
                self.newsdelegate?.didFailDataUpdateWithError(error: "No news articles found")
            }
            
        }, onError: {(error)
            in
            self.newsdelegate?.didFailDataUpdateWithError(error: error.localizedDescription)
        })
 
    }
    
    
    func getSources(type:String, category: String){
        appServerClient.sendSourcesRequest(type:type, category: category,onSuccess: {(res)
            in
            if let sources = res.sources{
                self.sourcesdelegate?.didRecieveSourceResponse(response: sources)
            }else{
                self.sourcesdelegate?.didFailUpdateWithError(error: "No Sources found")
            }
            
        }, onError: {(error)
            in
            self.sourcesdelegate?.didFailUpdateWithError(error: error.localizedDescription)
        })
    }
    
}

fileprivate extension ApiServiceClient.GetFailureReason {
    func getErrorMessage() -> String? {
        switch self {
        case .unAuthorized:
            return "Request Anuthorized. Please check Api Credentials"
        case .notFound:
            return "Could not complete request, please try again."
        }
    }
}

