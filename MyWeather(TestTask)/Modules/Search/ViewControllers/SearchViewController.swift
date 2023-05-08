//
//  SearchViewController.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 02.05.2023.
//

import UIKit
import Lottie

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    
    private var models: [ForecastDay] = []
    private let gradientView = GradientView()
    private var animationView: LottieAnimationView?

    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a City"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(gradientView)
        configureNavBar()
        configureAnimationView()
        animationView?.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.frame = view.bounds
        gradientView.alpha = 0.4
    }
    
    //MARK: - Private Methods
    
    private func configureNavBar() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .label
        searchController.searchResultsUpdater = self
    }
    
    private func configureAnimationView() {
        animationView = .init(name: "city")
        animationView!.frame = CGRect(x: 0, y: 400, width: 370, height: 400)
        animationView?.center.x = self.view.center.x
        animationView!.contentMode = .scaleAspectFit
        animationView?.alpha = 0.7
        animationView?.loopMode = .loop
        view.addSubview(animationView!)
    }
}
    
//MARK: - SearchResultsDelegate

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        
        APICaller.shared.getCoordinates(forCity: query) { coordinates in
            if let coordinates = coordinates {
                let latitude = coordinates.latitude
                let longitude = coordinates.longitude
                
                if !latitude.isZero && !longitude.isZero {
                    APICaller.shared.requestWeatherForLocation(longitude: longitude, latitude: latitude) {  result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let result):
                                print(result.location)
                                let entries = result.forecast.forecastday
                                    resultController.models = entries
                                    resultController.searchResultsCollectionView.reloadData()
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
}
