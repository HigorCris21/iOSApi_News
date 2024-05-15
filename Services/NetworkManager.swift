//
//  NetworkManager.swift
//  iOSApiNews
//
//  Created by Higor  Lo Castro on 15/05/24.
//


import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    private let apiKey = "d45484fa70224726ba6beb9c50d8c233"
    
    private init (){}
    
    func handleResponse(data: Data, response: URLResponse?) throws -> Result<[Article], RequestError> {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestError.errorRequest(error: "Invalid response")
        }
        
        if httpResponse.statusCode == 404 {
            return .failure(.wordNotFound)
        }
        
        do {
            let articlesResponse = try JSONDecoder().decode(ArticlesResponse.self, from: data)
            return .success(articlesResponse.articles)
        } catch {
            throw RequestError.decodingError
        }
    }
    
    
    func fetchData(completion: @escaping (Result<[Article], RequestError>) -> Void) {
        let urlString = "\(baseURL)?country=us&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response else {
                completion(.failure(.errorRequest(error: error?.localizedDescription ?? "Unknown error")))
                return
            }
            
            do {
                let result = try self.handleResponse(data: data, response: response)
                completion(result)
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
