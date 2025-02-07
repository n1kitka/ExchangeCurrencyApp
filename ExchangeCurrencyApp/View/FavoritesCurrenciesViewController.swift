//
//  FavoritesCurrenciesViewController.swift
//  ExchangeCurrencyApp
//
//  Created by Nikita on 29.01.2025.
//

import UIKit
import Combine

class FavoritesCurrenciesViewController: UIViewController {

    var viewModel: CurrencyViewModel!
    private var cancellables = Set<AnyCancellable>()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
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
        viewModel.$favoriteRates
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
    }
}

extension FavoritesCurrenciesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteRates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyListCell", for: indexPath) as? CurrencyListCell else {
            return UITableViewCell()
        }
        let rate = viewModel.favoriteRates[indexPath.row]
        cell.setCurrency(rate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
