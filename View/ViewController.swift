//
//  ViewController.swift
//  iOSApiNews
//
//  Created by Higor  Lo Castro on 15/05/24.
//

import UIKit

class ViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let articles):
                print("Articles received from API:", articles)
            case .failure(let error):
                print("Error fetching articles:", error.errorMessage)
            }
        }
    }

}

