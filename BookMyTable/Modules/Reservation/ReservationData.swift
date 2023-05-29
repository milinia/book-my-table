//
//  ReservationData.swift
//  BookMyTable
//
//  Created by Evelina on 08.05.2023.
//

import Foundation
import UIKit

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
    let status: String
}

enum ReservationStatus: String {
    case cancel = "Отменено"
    case process = "Ожидается"
    case done = "Завершена"
}
