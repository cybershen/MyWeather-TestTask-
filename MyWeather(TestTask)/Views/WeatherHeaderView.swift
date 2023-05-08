//
//  WeatherHeaderView.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 06.05.2023.
//

import UIKit
import Lottie

class WeatherHeaderView: UICollectionReusableView {
    
    private var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45)
        label.numberOfLines = 0
        label.text = ""
        label.textColor = .black
        return label
    }()
    
    private var animationView: LottieAnimationView = {
        var view = LottieAnimationView()
        view = .init(name: "wind")
        view.contentMode = .scaleAspectFit
        view.play()
        view.loopMode = .loop
        return view
    }()
    
    //MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel(with: mainLabel, and: "My Weather")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainLabel.frame = CGRect(x: 70, y: 30, width: 500, height: 200)
        animationView.frame = CGRect(x: 50, y: 120, width: 300, height: 300)
        
        addSubview(mainLabel)
        addSubview(animationView)
    }
    
    //MARK: - Private Methods
    
    private func configureLabel(with label: UILabel, and str: String) {
        label.text = ""
        var charIndex = 0.0
        
        for character in str {
            Timer.scheduledTimer(withTimeInterval: 0.090 * charIndex, repeats: false) {
                (timer) in label.text?.append(character)
            }
            charIndex += 1
        }
    }
}

