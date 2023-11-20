//
//  CatsListViewController.swift
//  CatFacts
//
//  Created by Mariam Mchedlidze on 20.11.23.
//

import NetworkManager
import UIKit

final class CatsListViewController: UIViewController {
    private var cats = [Cats]()
    private var viewModel = CatsListView()
    
    // MARK: - Properties
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.viewDidLoad()
        setupDelegate()
    }
    
    // MARK: - Private Methods
    private func setup() {
        collectionView.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        collectionView.layer.borderWidth = 1
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        collectionView.register(CatCellView.self, forCellWithReuseIdentifier: "CatItemCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupDelegate(){
        viewModel.delegate = self
    }
    
}

// MARK: - CollectionView DataSource
extension CatsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatItemCell", for: indexPath) as? CatCellView else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: cats[indexPath.row])
        return cell
    }
}

// MARK: - CollectionView FlowLayoutDelegate
extension CatsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + flowLayout.minimumInteritemSpacing
        
        let width = Int((collectionView.bounds.width - totalSpace) )
        let height = 50
        
        return CGSize(width: width, height: height)
    }
}


extension CatsListViewController: CatsListViewDelegate {
    func fetched(_ cats: [Cats]) {
        self.cats = cats
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func error(_ error: Error) {
        print(error)
    }
}
