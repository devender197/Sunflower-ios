//
//  PostRequestModel.swift
//  GithubProfiler
//
//  Created by Devender Singh on 5/7/25.
//

import Foundation

class PostRequestModel: ApiClientProtocol {
    private var _url: String = ""
    
    var body: [String : String]?
    
    var headers: [String : String]?
    
    var url: String {
        get { _url }
        set { _url = newValue }
    }
    internal var apiRequestType: ApiRequestType = ApiRequestType.POST
    
    func getRequestModel() -> URLRequest {
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = apiRequestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        return request
    }
}
