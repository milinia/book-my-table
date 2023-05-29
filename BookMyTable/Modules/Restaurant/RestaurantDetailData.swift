//
//  RestaurantDetailData.swift
//  BookMyTable
//
//  Created by Evelina on 08.05.2023.
//

import Foundation

struct RestaurantDetailData {
    let latitude: Double
    let longitude: Double
    let title: String
    let rating: Double
    let cuisine: String
    let description: String
    let address: String
    let openingHours: String
    let images: [Data]
    let like: Bool
    let reviews: [ReviewData]
}
