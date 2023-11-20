//
//  CatCellView.swift
//  CatFacts
//
//  Created by Mariam Mchedlidze on 20.11.23.
//

import NetworkManager
import UIKit

final class CatCellView: UICollectionViewCell {
    private var cat = [Cats]()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var titleGenreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - CellLifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    // MARK: - Private Methods
    private func addSubview() {
        contentView.addSubview(titleGenreStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleGenreStackView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            titleGenreStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleGenreStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])     
    }
    
    // MARK: - Configuration
    func configure(with cats: Cats) {
        titleLabel.text = cats.fact
    }
}


