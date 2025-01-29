//
//  CurrencyListCell.swift
//  ExchangeCurrencyApp
//
//  Created by Nikita on 29.01.2025.
//

import UIKit
import SnapKit

final class CurrencyListCell: UITableViewCell {
    private let mainTextSize: CGFloat = 20
    private let dateLabelSize: CGFloat = 16

    private lazy var currencyNameLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: mainTextSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var rateLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: mainTextSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: dateLabelSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rateLbl, dateLbl])
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = 2
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public

extension CurrencyListCell {
    func setCurrency(_ currency: CurrencyRate) {
        currencyNameLbl.text = currency.identifier
        rateLbl.text = "\(currency.quote)"
        dateLbl.text = currency.date
    }
}

// MARK: - Private

private extension CurrencyListCell {
    func setupSubviews() {
        contentView.addSubview(currencyNameLbl)
        contentView.addSubview(rateStackView)
    }

    func setupConstraints() {
        currencyNameLbl.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
        
        rateStackView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
}
