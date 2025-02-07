//
//  CurrencyRatesViewController.swift
//  ExchangeCurrencyApp
//
//  Created by Nikita on 29.01.2025.
//

import UIKit
import Combine
import SnapKit

class CurrencyRatesViewController: UIViewController {
    var viewModel: CurrencyViewModel!
    private var cancellables = Set<AnyCancellable>()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        viewModel.fetchRates()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrencyListCell.self, forCellReuseIdentifier: "CurrencyListCell")
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

    private func bindViewModel() {
        viewModel.$rates
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension CurrencyRatesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyListCell", for: indexPath) as? CurrencyListCell else {
            return UITableViewCell()
        }
        let rate = viewModel.rates[indexPath.row]
        cell.setCurrency(rate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let rate = viewModel.rates[indexPath.row]
        let isFavorite = viewModel.favoriteRates.contains { $0.identifier == rate.identifier }
        
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            if isFavorite {
                self.viewModel.removeFromFavorites(rate)
            } else {
                self.viewModel.addToFavorites(rate)
            }
            
            completionHandler(true)
        }

        favoriteAction.image = UIImage(systemName: isFavorite ? "star.fill" : "star")
        favoriteAction.backgroundColor = .systemGray.withAlphaComponent(0.2)
        
        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return configuration
    }
}

