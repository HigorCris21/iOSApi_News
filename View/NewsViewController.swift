//
//  NewsViewController.swift
//  iOSApiNews
//
//  Created by Higor  Lo Castro on 15/05/24.
//

import UIKit

class NewsViewController: UIViewController {
    private let networkService: NetworkService
    
    private var articles: [Article] = []
    
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    
        
    }
    
    private func fetchData() {
        networkService.fetchData { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                // Chama o método para imprimir os artigos
                self?.printArticles()
                // Adicione uma instrução de impressão para verificar se o método está sendo chamado
                print("printArticles() chamado com sucesso.")
            
            case .failure(let error):
                print("Erro ao buscar dados: \(error.errorMessage)")
            }
        }
    }

    
    private func printArticles() {
        for article in articles {
            print("Title: \(article.title)")
            if let author = article.author {
                print("Author: \(author)")
            }
            if let description = article.description {
                print("Description: \(description)")
            }
            print("URL: \(article.url)")
            print("Published At: \(article.publishedAt)")
            print("------------------------------------")
        }
    }
}
