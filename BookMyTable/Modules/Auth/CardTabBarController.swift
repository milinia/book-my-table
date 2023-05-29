//
//  CardTabBarController.swift
//  BookMyTable
//
//  Created by Evelina on 28.05.2023.
//

import Foundation

import UIKit

class CardTabBarController: TabBarController {

    override func makeTabBar() -> BaseCardTabBar {
        CardTabBar()
    }
}
