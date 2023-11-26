//
//  BreedCatFactViewModel.swift
//  Davaleba26
//
//  Created by Lika Nozadze on 11/27/23.
//
import Foundation
import NetworkLayer

protocol BreedCatFactViewModelDelegate: AnyObject {
    func fetchedFact(_ breedCatFacts: [breedFact])
    func showError(_ error: Error)
}


class BreedCatFactViewModel {
    private let networkManager: NetworkManager
    weak var delegate: BreedCatFactViewModelDelegate?

    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }
        func viewDidLoad() {
            fetchData()
        }
    

    func fetchData() {
        let urlString = "https://catfact.ninja/breeds?limit=20"

        guard let url = URL(string: urlString) else {
            delegate?.showError(NetworkError.invalidURL)
            return
        }

        networkManager.fetchData(from: url, responseType: BreedResults.self) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let BreedResults):
                let breedFact = BreedResults.data
                self.delegate?.fetchedFact(breedFact)

            case .failure(let error):
                self.delegate?.showError(error)
            }
        }
    }
}
