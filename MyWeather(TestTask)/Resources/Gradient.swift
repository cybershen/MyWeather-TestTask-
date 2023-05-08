//
//  Gradient.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 02.05.2023.
//

import UIKit

class GradientView: UIView {
    
    //MARK: - Properties
    
    let gradient = CAGradientLayer()
    
    //MARK: - Constructors

    override init(frame: CGRect) {
        super.init(frame:frame)
        setupGradient(color: UIColor.systemGreen)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient(color: UIColor.systemGreen)
    }
    
    //MARK: - Methods
    
    func setupGradient(color: UIColor ) {
        gradient.colors = [
            UIColor.systemCyan.cgColor,
            UIColor.systemGreen.cgColor,
            UIColor.purple.cgColor,
            UIColor.blue.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.black.cgColor
        ]

        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        layer.addSublayer(gradient)
    }
    
    //MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
