//
//  ApiClient.swift
//  GithubProfiler
//
//  Created by Devender Singh on 5/4/25.
//

import Foundation

class ApiClient {
    
    static let shared = ApiClient()
    
    
    
    
    func call<N: Decodable>(request: ApiClientProtocol) async throws -> N {
        switch(request.apiRequestType) {
            case .GET:
                return try await handleGetRequest(model: request)
            case .POST:
                return try await handlePostRequest(model: request)
            }
    }
    
    func handleGetRequest<N: Decodable>(model: ApiClientProtocol) async throws -> N {
        let (data, response) = try await URLSession.shared.data(for: model.getRequestModel())
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiErrors.invalidResponse
        }
        /*let raw = String(data: data, encoding: .utf8) ?? "<no body>"
        print("📦 Raw response: \(raw)")*/
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(N.self, from: data)
        } catch {
            throw ApiErrors.invalidData
        }
    }
    
    func handlePostRequest<N: Decodable>(model: ApiClientProtocol) async throws -> N {
        
        let (data, response) = try await URLSession.shared.data(for: model.getRequestModel())
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiErrors.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(N.self, from: data)
        } catch {
            throw ApiErrors.invalidData
        }
    }
}
