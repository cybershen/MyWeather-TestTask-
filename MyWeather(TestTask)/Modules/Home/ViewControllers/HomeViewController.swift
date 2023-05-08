//
//  HomeViewController.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 02.05.2023.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private var weatherHeaderView: WeatherHeaderView?
    private let gradientView = GradientView()
    private var collectionView: UICollectionView!
    private var safariLayout = SafariIPhoneCollectionViewLayout()
    
    var models: [ForecastDay] = []
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(gradientView)
        view.sendSubviewToBack(gradientView)
        setupCollectionView()
        setupLocation()
        configureWeatherHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.frame = view.bounds
        gradientView.alpha = 0.4
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Location
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Private Methods
    
    private func configureWeatherHeaderView() {
        weatherHeaderView = WeatherHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        view.addSubview(weatherHeaderView!)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 380, width: view.bounds.width, height: view.bounds.height - 400), collectionViewLayout: safariLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: WeatherCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        collectionView.register(WeatherHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
}

//MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as? WeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let model = models[indexPath.row]
        
        cell.configure(with: model)
        
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! WeatherHeaderView
        return headerView
    }
}

//MARK: - CLLocationManagerDelegate

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            APICaller.shared.requestWeatherForLocation(longitude: (currentLocation?.coordinate.longitude)!, latitude: (currentLocation?.coordinate.latitude)!) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let result):
                        let entries = result.forecast.forecastday
                        self?.models.append(contentsOf: entries)
                        self?.collectionView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
    
