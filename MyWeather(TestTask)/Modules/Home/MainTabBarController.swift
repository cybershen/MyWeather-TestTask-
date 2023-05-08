//
//  MainTabBarController.swift
//  MyWeather(TestTask)
//
//  Created by Назар Жиленко on 02.05.2023.
//

import UIKit
import Lottie

class MainTabBarController: UITabBarController {
    
    //MARK: - Properties
    
    private var animationView: LottieAnimationView?
    private var gradientView = GradientView()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(gradientView)
        tabBar.isHidden = true
        tabBar.alpha = 1
        configureAnimationView()
        animationView?.play()
        stopAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.frame = view.bounds
        gradientView.alpha = 0.4
    }
    
    //MARK: - Private Methods
    
    private func configureAnimationView() {
        animationView = .init(name: "weather")
        animationView!.frame = CGRect(x: 10, y: 200, width: 400, height: 400)
        animationView!.contentMode = .scaleAspectFit
        view.addSubview(animationView!)
        tabBar.isHidden = true
    }
    
    private func stopAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.animationView?.stop()
            self?.animationView?.isHidden = true
            self?.tabBar.isHidden = false
            self?.configureTabBarController()
            self?.gradientView.isHidden = true
        }
    }
    
    private func configureGradientForTabBar() {
        tabBar.backgroundColor = .white

        let redValue: CGFloat = 33.0 / 255.0
        let greenValue: CGFloat = 22.0 / 255.0
        let blueValue: CGFloat = 3.0 / 255.0
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = tabBar.bounds
        gradientLayer.colors = [
            UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0).cgColor,
            UIColor.systemGreen.cgColor ,
            UIColor.systemBlue,
            UIColor.white
        ]

        tabBar.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func configureTabBarController() {
        configureGradientForTabBar()

        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        
        vc1.tabBarItem.image = UIImage(assetIdentifier: .house)
        vc2.tabBarItem.image = UIImage(assetIdentifier: .magnifyingGlass)
        
        vc1.title = Constants.MainVCTitle.home
        vc2.title = Constants.MainVCTitle.search
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2], animated: true)
    }
}
