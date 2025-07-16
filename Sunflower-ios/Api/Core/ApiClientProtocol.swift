//
//  ApiClientProtocol.swift
//  GithubProfiler
//
//  Created by Devender Singh on 5/7/25.
//

import Foundation

protocol ApiClientProtocol {
    var url: String { get set}
    var body: [String : String]? { get set}
    var apiRequestType: ApiRequestType { get set}
    var headers: [String : String]? { get set}
    
    func getRequestModel() -> URLRequest 
}
