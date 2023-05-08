//
//  APICaller.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 06.05.2023.
//

import Foundation
import CoreLocation

final class APICaller {
    
    //MARK: - Properties
    
    static let shared = APICaller()
    
    //MARK: - Constructors
    
    private init() {}
    
    //MARK: - Error Enum
    
    enum APIError: Error {
        case failedToGetData
    }
    
    //MARK: - Private Methods
    
    public func requestWeatherForLocation(longitude: CLLocationDegrees, latitude: CLLocationDegrees, completion: @escaping (Result<WeatherForecast, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.API.baseURL)/forecast.json?key=\(Constants.API.API_KEY)&q=\(longitude),\(latitude)&days=14") else {
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            do {
                let weatherForecast = try JSONDecoder().decode(WeatherForecast.self, from: data)
                completion(.success(weatherForecast))
            }
            catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getCoordinates(forCity city: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { (placemarks, error) in
            guard let placemark = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            
            let coordinates = placemark.location?.coordinate
            completion(coordinates)
        }
    }
}

