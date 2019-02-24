//
//  UIColor + theme.swift
//  GymExpert
//
//  Created by Admin on 2/2/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupPlusButtonInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    func setupLightBlueBackgroundView(height: CGFloat) -> UIView {
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightBlueBackgroundView)
        
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return lightBlueBackgroundView
    }
}
