//
//  GetRequestModel.swift
//  GithubProfiler
//
//  Created by Devender Singh on 5/8/25.
//

import Foundation

class GetRequestModel : ApiClientProtocol {
    private var _url: String = "" 
        
        var url: String {
            get { _url }
            set { _url = newValue }
        }
    
    var body: [String : String]?
    
    var apiRequestType: ApiRequestType = ApiRequestType.GET
    
    var headers: [String : String]?
    
    func getRequestModel() -> URLRequest {
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = apiRequestType.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // header
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // body
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        return request
    }
}
