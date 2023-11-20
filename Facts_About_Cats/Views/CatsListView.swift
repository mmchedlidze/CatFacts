//
//  CatsListView.swift
//  CatFacts
//
//  Created by Mariam Mchedlidze on 20.11.23.
//
import NetworkManager
import Foundation

protocol CatsListViewDelegate: AnyObject {
    func fetched(_ cats: [Cats])
    func error(_ error: Error)
}

final class CatsListView {
    
    func viewDidLoad() {
        fetchMovies()
    }
    
    private var cats : [Cats]?
    weak var delegate: CatsListViewDelegate?
    
    func fetchMovies() {
        
        NetworkManager.shared.fetchMovies { [weak self] result in
            switch result {
            case .success(let cats):
                self?.cats = cats
                self?.delegate?.fetched(cats)
            case .failure(let error):
                self?.delegate?.error(error)
            }
        }
    }
}
