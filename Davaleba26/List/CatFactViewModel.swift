//
//  catFactViewModel.swift
//  Davaleba26
//
//  Created by Lika Nozadze on 11/19/23.


import Foundation
import NetworkLayer

public enum NetworkError: Error {
    case invalidURL
    case noDataReceived
    case decodingError
}

protocol CatFactViewModelDelegate: AnyObject {
    func fetchedFact(_ facts: [catFact])
    func showError(_ error: Error)
}

class CatFactViewModel {
    private let networkManager: NetworkManager
    weak var delegate: CatFactViewModelDelegate?

    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }
        func viewDidLoad() {
            fetchData()
        }
    

    func fetchData() {
        let urlString = "https://catfact.ninja/facts?limit=20"

        guard let url = URL(string: urlString) else {
            delegate?.showError(NetworkError.invalidURL)
            return
        }

        networkManager.fetchData(from: url, responseType: CatResults.self) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let catResults):
                let catFacts = catResults.data
                self.delegate?.fetchedFact(catFacts)

            case .failure(let error):
                self.delegate?.showError(error)
            }
        }
    }
}
