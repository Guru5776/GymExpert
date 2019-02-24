//
//  UIViewController+Helpers.swift
//  GymExpert
//
//  Created by Admin on 1/18/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupPlusButtonInNavBar(selectore: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selectore)
    }
    
    func setupCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil)
    }
}
