//
//  ViewController.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Type properties
    
    static let padding: CGFloat = 16.0
    
    // MARK: Instance properties
    
    private var collectionView: UICollectionView?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
    }
    
    // MARK: Private methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Gallery"
        
        let buttonImage = UIImage(systemName: "arrow.clockwise.circle")
        let buttonItem = UIBarButtonItem(image: buttonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapRefreshButton))

        navigationItem.rightBarButtonItem = buttonItem
    }
    
    @objc private func didTapRefreshButton() {
        print("Refresh!")
    }
    
}

// MARK: - Setup CollectionView

extension ViewController {
    private func setupCollectionView() {
        let layout = setupCollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        
        view.addSubview(collectionView)
        setupCollectionViewConstraints(collectionView)
    }
    
    private func setupCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let itemSize = view.frame.size.width*0.18
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Self.padding
        layout.minimumInteritemSpacing = Self.padding
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        return layout
    }
    
    private func setupCollectionViewConstraints(_ collectionView: UICollectionView) {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Self.padding).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Self.padding).isActive = true
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell else {
            print("Could not instantiate ImageCell.")
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    }
}
