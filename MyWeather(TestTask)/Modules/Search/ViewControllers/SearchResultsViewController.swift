//
//  SearchResultsViewController.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 08.05.2023.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    //MARK: - Properties
    
    public var models: [ForecastDay] = []
    private let gradientView = GradientView()
        
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: SearchWeatherCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchWeatherCell.identifier)
        return collectionView
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(gradientView)
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.frame = view.bounds
        gradientView.alpha = 0.4
        searchResultsCollectionView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(models.count)
    }
}

//MARK: - UICollectionViewDelegate

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchWeatherCell.identifier, for: indexPath) as? SearchWeatherCell else {
            return UICollectionViewCell()
        }
        
        let model = models[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}
