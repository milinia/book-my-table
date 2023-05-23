//
//  ReservationData.swift
//  BookMyTable
//
//  Created by Evelina on 08.05.2023.
//

import Foundation

struct FreeReservationData {
    let time: [String]
    let date: Date
}

struct ReservationData {
    let time: String
    let date: String
    let restaurantName: String
    let restaurantAddress: String
    let guestsNumber: Int
    let restaurantImage: Data
}
