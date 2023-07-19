//
//  CatsGalleryViewController.swift
//  CatsGallery
//
//  Created by Matheus Moreira on 17/07/23.
//

import UIKit
import Combine

class CatsGalleryViewController: UIViewController {
    
    // MARK: Type properties
    
    static let padding: CGFloat = 16.0
    
    // MARK: Instance properties
    
    private var collectionView: UICollectionView?
    private var cancellables = Set<AnyCancellable>()
    var viewModel = CatsGalleryViewModel()
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Clique\nno botão\npara baixar\nas imagens"
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        setupLabel()
    }
    
    // MARK: UI methods
    
    private func setupLabel() {
        view.addSubview(label)
        label.widthAnchor.constraint(equalToConstant: 500).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Gallery"
        
        let buttonImage = UIImage(systemName: "arrow.clockwise.circle")
        let buttonItem = UIBarButtonItem(image: buttonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(didTapRefreshButton))

        navigationItem.rightBarButtonItem = buttonItem
    }
    
    private func erase() {
        label.isHidden = true
        viewModel.erase()
        self.collectionView?.reloadData()
    }
    
    // MARK: Networking methods
    
    @objc private func didTapRefreshButton() {
        
        let searchResult = viewModel.searchCatsPosts(execute: { erase() })
        
        searchResult.sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                switch error {
                case .generic(error: let error):
                    print("Search - Generic error: \(error)")
                case .invalidURL:
                    print("Search - Invalid URL")
                case .noData:
                    print("Search - No data")
                case .parsingError(error: let error):
                    print("Search - Parsing error: \(error)")
                }
            }
        } receiveValue: { [unowned self] _ in
            print("Search was successful!")
            if self.viewModel.hasLinks {
                self.downloadImages(onRange: self.viewModel.initialRange)
            }
        }.store(in: &cancellables)
    }
    
    private func downloadImages(onRange range: ClosedRange<Int>) {
        let downloads = self.viewModel.downloadCatsImages(onRange: range)
        
        downloads.forEach {
            $0.sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case .generic(error: let error):
                        print("Download - Generic error: \(error)")
                    case .invalidURL:
                        print("Download - Invalid URL")
                    case .noData:
                        print("Download - No data")
                    case .parsingError(error: let error):
                        print("Download - Parsing error: \(error)")
                    }
                }
            } receiveValue: { _ in
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }.store(in: &cancellables)
        } // forEach
        
    }
}

// MARK: - Setup CollectionView

extension CatsGalleryViewController {
    private func setupCollectionView() {
        let layout = setupCollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
        collectionView.dataSource = self
//        collectionView.prefetchDataSource = self
        
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

extension CatsGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalDisplay
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell else {
            print("Could not instantiate ImageCell.")
            return UICollectionViewCell()
        }
        
        if indexPath.row >= viewModel.imagesData.count {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath)
        }
        
        let imageData = viewModel.imagesData[indexPath.row]
        let catImage = UIImage(data: imageData)
        let placeholder = UIImage(named: "placeholder")
        
        cell.imageView.image = catImage ?? placeholder
        return cell
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
// Tentei usar mas não consegui implementar como gostaria

extension CatsGalleryViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetching...")
        let paths = indexPaths.sorted(by: { $0.row < $1.row } )
        let filter = paths.filter { $0.row >= viewModel.totalDisplay - 1 }
        if filter.isEmpty { return }
        
        viewModel.totalDisplay += 4

        let firstIndex = filter.first!.row
        let lastIndex = filter.last!.row
        downloadImages(onRange: firstIndex...lastIndex)
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
    }
}
