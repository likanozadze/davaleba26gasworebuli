//
//  BreedCatFactViewController.swift
//  Davaleba26
//
//  Created by Lika Nozadze on 11/27/23.
//

// BreedCatFactViewController.swift

import UIKit

final class BreedCatFactViewController: UIViewController {

    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var breedCatFacts = [breedFact]()  // Assuming catFact is your data model for cat facts
    
    private let viewModel = BreedCatFactViewModel()  // You need to create a ViewModel for cat breeds
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupSubviews()
        setupConstraints()
        setupTableView()
        viewModel.viewDidLoad()
    }

    // MARK: - Private Methods
    private func setupBackground() {
        view.backgroundColor = .white
    }

    private func setupSubviews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }

    private func setupTableView() {
        tableView.dataSource = self
        viewModel.delegate = self
        tableView.register(BreedCatFactTableViewCell.self, forCellReuseIdentifier: "BreedCell")
    }
}

// MARK: - TableView DataSource
extension BreedCatFactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BreedCell", for: indexPath) as? BreedCatFactTableViewCell {
            let breedFact = breedCatFacts[indexPath.row]
            cell.configure(with: breedFact)
            return cell

        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breedCatFacts.count
    }
}

// MARK: - TableView Delegate
extension BreedCatFactViewController: BreedCatFactViewModelDelegate {
    func fetchedFact(_ breed: [breedFact]) {
        self.breedCatFacts = breed
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showError(_ error: Error) {
        print("Breed Error: \(error.localizedDescription)")
    }
}

  
