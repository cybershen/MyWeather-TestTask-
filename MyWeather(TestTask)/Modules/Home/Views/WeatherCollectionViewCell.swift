//
//  WeatherCollectionViewCell.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 03.05.2023.
//

import UIKit
import SDWebImage

class WeatherCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var cellView: UIView!
    
    //MARK: - Properties
    
    static let identifier = "WeatherCollectionViewCell"
    private let gradientView = GradientView()
    
    //MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
        cellView.backgroundColor = .systemGreen
        cellView.addSubview(gradientView)
        cellView.addSubview(dayLabel)
        cellView.addSubview(highTempLabel)
        cellView.addSubview(lowTempLabel)
        cellView.addSubview(iconImageView)
        cellView.layer.cornerCurve = .continuous
        
        gradientView.frame = cellView.bounds
        gradientView.alpha = 0.3
        
        let backgroundImage = UIImage(named: "1641.jpg")
        let backgroundImageView = UIImageView(frame: cellView.bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.alpha = 0.9
        backgroundImageView.contentMode = .scaleToFill

        cellView.addSubview(backgroundImageView)
        cellView.sendSubviewToBack(backgroundImageView)
    }
    
    //MARK: - Methods
    
    func configure(with model: ForecastDay) {
        lowTempLabel.text = "\(Int(model.day.mintemp_c))°"
        highTempLabel.text = "\(Int(model.day.maxtemp_c))°"
        dayLabel.text = getDay(with: model.date)

        guard let url = URL(string: "https:" + model.day.condition.icon) else { return }
        iconImageView.sd_setImage(with: url)
        iconImageView.contentMode = .scaleAspectFill
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        cellView.layer.cornerRadius = self.frame.height / 11.0
        cellView.layer.masksToBounds = true
        cellView.alpha = 1
    }
    
    private func getDay(with date: String) -> String {
        var day = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let dayOfWeek = calendar.component(.weekday, from: date)
            
            let englishLocale = Locale(identifier: "en_US")
            dateFormatter.locale = englishLocale
            
            let weekdaySymbols = dateFormatter.weekdaySymbols
            
            let dayOfWeekName = weekdaySymbols![dayOfWeek - 1]
            day = dayOfWeekName
        } else {
            print("Invalid date format")
        }
        return day
    }
}
