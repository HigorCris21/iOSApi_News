//
//  WordService.swift
//  iOSApiNews
//
//  Created by Higor  Lo Castro on 15/05/24.
//

import Foundation

struct WordService {
    
    private let networkManager = NetworkManager.shared
 
    var cache: [String: Article] = [:]
    
    private mutating func saveCache() {
        cacheManager.saveCache(cache)
    }
    
    mutating func loadCache() {
        if let decodeCache = cacheManager.loadCache() {
            cache = decodeCache
        }
    }
    
    mutating func getArticles(completion: @escaping (Result<[Article], RequestError>) -> Void) {
        
        loadCache()
        
        if !cache.isEmpty {
            print("Retrieving articles from cache...")
            completion(.success(Array(cache.values)))
            return
        }
        
        do {
            if requestManager.isRequestLimitExceeded() {
                completion(.failure(.limitExceeded))
                return
            }
            
            networkManager.fetchData { result in
                switch result {
                case .success(let articles):
                    self.cacheArticles(articles)
                    completion(.success(articles))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(.errorRequest(error: error.localizedDescription)))
        }
    }
    
    private mutating func cacheArticles(_ articles: [Article]) {
        for article in articles {
            cache[article.title] = article
        }
        saveCache()
    }
}
