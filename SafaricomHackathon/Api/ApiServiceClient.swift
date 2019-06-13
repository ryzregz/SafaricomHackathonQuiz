//
//  ApiServiceClient.swift
//  SafaricomHackathon
//
//  Created by Eclectics on 13/06/2019.
//  Copyright © 2019 Safaricom. All rights reserved.
//

import Foundation
import Alamofire
import os
class ApiServiceClient{
    enum GetFailureReason: Int, Error{
        case unAuthorized = 401
        case notFound = 404
    }
    static var TAG:String = "ApiService"
    let configs = Config()
    private static var client:ApiServiceClient?
    
    static var client_instance:ApiServiceClient{
        get{
            if ApiServiceClient.client == nil{
                ApiServiceClient.client = ApiServiceClient()
            }
            return ApiServiceClient.client!
        }
    }
    func sendNewsRequest(type: String,category:String,onSuccess:@escaping (_ response: Response)->Void, onError: @escaping (_ error: Error)->Void) {
       var url = configs.BASEURL
        //url += "language=\(configs.COUNTRY)&apiKey=\(configs.APIKEY)"
       // var parameters: [String: Any]
        
        if category == ""{
            url += "\(type)?language=en&country=\(configs.COUNTRY)&apiKey=\(configs.APIKEY)"
            //parameters  = ["apiKey":configs.APIKEY,"country": configs.COUNTRY] as [String : Any]
        }else{
            url += "\(type)?language=en&country=\(configs.COUNTRY)&apiKey=\(configs.APIKEY)&\(category)"
            //parameters  = ["category":category, "apiKey":configs.APIKEY] as [String : Any]
        }
        let headers: HTTPHeaders = [ "Content-Type" : "application/json" , "Accept" : "application/json"]
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.queryString, headers: headers)
            .validate()
            .responseString { response in
                print("RESPONSE \(response.debugDescription)")
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            return
                        }
                        
                        let res = try JSONDecoder().decode(Response.self, from: data)
                         print("API Response \(res)")
//                        let m = "Response: \(res)"
//                        os_log("%@", m)
                        onSuccess(res)
                        
                    } catch {
                        print("JSON DECODING ERROR \(error)")
//                        let logMessage = "JSON Decoding error response: \(error.localizedDescription)"
//                        os_log("%@", logMessage)
                        onError(error)
                    }
                case .failure(_):
                    print("API Error Response \(String(describing: response.response?.debugDescription))")
//                    let api_error = "HTTP response: \(String(describing: response.response?.debugDescription))"
//                    os_log("%@", api_error)
                    if let statusCode = response.response?.statusCode,
                        let reason = GetFailureReason(rawValue: statusCode) {
                        onError(reason)
                    }
                }
        }
    }
    
    func sendSourcesRequest(type: String,category:String,onSuccess:@escaping (_ response: SourcesResponse)->Void, onError: @escaping (_ error: Error)->Void) {
        var url = configs.BASEURL
        //url += "language=\(configs.COUNTRY)&apiKey=\(configs.APIKEY)"
        // var parameters: [String: Any]
        
        if category == ""{
            url += "\(type)?language=en&country=\(configs.COUNTRY)&apiKey=\(configs.APIKEY)"
            //parameters  = ["apiKey":configs.APIKEY,"country": configs.COUNTRY] as [String : Any]
        }else{
            url += "\(type)?language=en&country=\(configs.COUNTRY)&apiKey=\(configs.APIKEY)&\(category)"
            //parameters  = ["category":category, "apiKey":configs.APIKEY] as [String : Any]
        }
        let headers: HTTPHeaders = [ "Content-Type" : "application/json" , "Accept" : "application/json"]
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.queryString, headers: headers)
            .validate()
            .responseString { response in
                print("RESPONSE \(response.debugDescription)")
                switch response.result {
                case .success:
                    do {
                        guard let data = response.data else {
                            return
                        }
                        
                        let res = try JSONDecoder().decode(SourcesResponse.self, from: data)
                        print("API Response \(res)")
                        //                        let m = "Response: \(res)"
                        //                        os_log("%@", m)
                        onSuccess(res)
                        
                    } catch {
                        print("JSON DECODING ERROR \(error.localizedDescription)")
                        //                        let logMessage = "JSON Decoding error response: \(error.localizedDescription)"
                        //                        os_log("%@", logMessage)
                        onError(error)
                    }
                case .failure(_):
                    print("API Error Response \(String(describing: response.response?.debugDescription))")
                    //                    let api_error = "HTTP response: \(String(describing: response.response?.debugDescription))"
                    //                    os_log("%@", api_error)
                    if let statusCode = response.response?.statusCode,
                        let reason = GetFailureReason(rawValue: statusCode) {
                        onError(reason)
                    }
                }
        }
    }
    
}
