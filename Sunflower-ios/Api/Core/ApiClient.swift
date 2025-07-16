//
//  ApiClient.swift
//  GithubProfiler
//
//  Created by Devender Singh on 5/4/25.
//

import Foundation

class ApiClient {
    
    static let shared = ApiClient()
    
    func getUser(with accessToken: String) async throws -> GitHubUser {
        let userRequest = GithubUserRequest(url: ApiUrls.getUser.rawValue, accessToken: accessToken)
        return try await call(request: userRequest)
    }
    
    func getUserOrganizations(with accessToken: String) async throws -> [OrganizationResponseModel] {
        let request = UrlBasedAuthRequest(url: ApiUrls.getUserOrg.rawValue, accessToken: accessToken)
        return try await call(request: request)
    }
    
    func getUserOrgRepositories(for org: String, with accessToken: String) async throws -> [Repository] {
        let request = UrlBasedAuthRequest(url: "https://api.github.com/orgs/\(org)/repos", accessToken: accessToken)
        return try await call(request: request)
    }
    
    func getUserFollowers(forUser user: GitHubUser) async throws -> [FollowUser] {
        let request = UrlBasedGetRequestModel(url: user.followersUrl)
        return try await call(request : request)
    }
    
    func getUserFollowing(forUser user: GitHubUser) async throws -> [FollowUser] {
        let rawUrl = user.followingUrl
        let cleanUrl = rawUrl.components(separatedBy: "{").first ?? rawUrl
        let request = UrlBasedGetRequestModel(url: cleanUrl)
        return try await call(request: request)
    }
    
    func getRepository(repoUrl url: String, with accessToken: String) async throws -> [Repository] {
        let request = UserRepoRequest(url: "https://api.github.com/user/repos" , accessToken: accessToken)
        return try await call(request: request)
    }
    
    func getUserLoginToken(code: String) async throws -> GitHubTokenResponse {
        let url = "https://github.com/login/oauth/access_token"
        let body = [
                "client_id": "Ov23limYhPNdnKDcFaqb",
                "client_secret": "ffdf39085dd311b68e34f03188b98c67707f77cc",
                "code": code,
                "redirect_uri": "hubradar://callback"
            ]
        let request = GithubLoginRequestModel(url: url, body: body)
        return try await call(request: request)
    }
    
    
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
            throw GitHubErrors.invalidResponse
        }
        /*let raw = String(data: data, encoding: .utf8) ?? "<no body>"
        print("📦 Raw response: \(raw)")*/
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(N.self, from: data)
        } catch {
            throw GitHubErrors.invalidData
        }
    }
    
    func handlePostRequest<N: Decodable>(model: ApiClientProtocol) async throws -> N {
        
        let (data, response) = try await URLSession.shared.data(for: model.getRequestModel())
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GitHubErrors.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(N.self, from: data)
        } catch {
            throw GitHubErrors.invalidData
        }
    }
}
